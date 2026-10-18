import type { AstroIntegration } from "astro";
import { execFile } from "node:child_process";
import { mkdir } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { promisify } from "node:util";

const execFileAsync = promisify(execFile);

export interface TypstOptions {
  /** Typst source file, relative to the project root. */
  input: string;
  /** Output file, relative to the site root (e.g. `resume.pdf`). */
  output: string;
  /** Typst binary to use. Defaults to `$TYPST` or `typst` from `$PATH`. */
  bin?: string;
}

/**
 * Compiles a Typst document with the `typst` CLI.
 *
 * - `astro build`: writes the PDF into the output directory.
 * - `astro dev`: serves a freshly compiled PDF on every request, so edits to
 *   the source show up on reload.
 */
export default function typst({
  input,
  output,
  bin = process.env.TYPST ?? "typst",
}: TypstOptions): AstroIntegration {
  let root = "";
  let base = "/";

  const compile = (dest: string) =>
    execFileAsync(
      bin,
      ["compile", "--root", root, path.resolve(root, input), dest],
      { encoding: "buffer", maxBuffer: 64 * 1024 * 1024 }
    );

  return {
    name: "typst",
    hooks: {
      "astro:config:setup": ({ config }) => {
        root = fileURLToPath(config.root);
        base = config.base;
      },

      "astro:server:setup": ({ server, logger }) => {
        const route = path.posix.join(base, output);

        server.middlewares.use(async (req, res, next) => {
          const url = new URL(req.url ?? "/", "http://localhost");
          if (url.pathname !== route) return next();

          try {
            const { stdout } = await compile("-");
            res.setHeader("Content-Type", "application/pdf");
            res.end(stdout);
          } catch (err) {
            const stderr =
              err instanceof Error && "stderr" in err
                ? String(err.stderr)
                : String(err);
            logger.error(`failed to compile ${input}\n${stderr}`);
            res.statusCode = 500;
            res.setHeader("Content-Type", "text/plain");
            res.end(stderr);
          }
        });
      },

      "astro:build:done": async ({ dir, logger }) => {
        const dest = path.join(fileURLToPath(dir), output);
        await mkdir(path.dirname(dest), { recursive: true });
        await compile(dest);
        logger.info(`compiled ${input} -> ${output}`);
      },
    },
  };
}

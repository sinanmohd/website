#import "@preview/simple-technical-resume:0.1.1": *

// Override: name on the left, stack right-aligned, no pipe separator.
#let project-heading(name, stack: "", project-url: "", body) = {
  let title = if project-url.len() != 0 { link(project-url)[*#name*] } else { [*#name*] }
  grid(
    columns: (1fr, auto),
    align(left)[#title],
    align(right)[*#stack*],
  )
  v(-0.2em)
  if body != [] {
    v(-0.4em)
    set par(leading: 0.6em)
    set list(indent: 0.5em)
    body
  }
}

#show: resume.with(
  author-name: "Sinan Mohd",
  phone: "+91 7012 432441",
  email: "sinan@sinanmohd.com",
  website: "sinanmohd.com",
  linkedin-user-id: "sinanmohd",
  github-username: "sinanmohd",
)

#custom-title("Experience")[
  #work-heading(
    "Staff Engineer",
    "Bud Ecosystem",
    "New York, US / Remote",
    datetime(year: 2025, month: 9, day: 1),
    "Present",
  )[
    - Wrote K8s operator to optimize cold start time, 40-400% performance gains on production LLM workloads
    - Implemented fault tolerant, high availability databases, storage solutions, and automated backup systems
    - Built various backend services, internal tools, features, and the primary user-facing administrative TUI
    - Identified and remediated vulnerabilities, code reviews, ensure project follows industry best practices
    - Integrated application and cluster telemetry/monitoring via OpenTelemetry, and automation pipelines
    - Led complete Infrastructure as Code (IaC) migration (BareMetal, NixOS, K8s, VXLAN, DSR, BGP)
  ]

  #work-heading(
    "Development and Operations Engineer",
    "NocoDB",
    "San Francisco, US / Remote",
    datetime(year: 2024, month: 9, day: 1),
    datetime(year: 2025, month: 9, day: 1),
  )[
    - Built a Managed Hosting Platform for NocoDB using Typescript, Nix, and AWS
    - Led the AWS Infrastructure as Code (IaC) Transition using Terraform and Nix
  ]

  #work-heading(
    "Software Development",
    link("https://summerofcode.withgoogle.com/programs/2024")[Google Summer of Code (GSoC)],
    "Mountain View, CA / Remote",
    datetime(year: 2024, month: 5, day: 1),
    datetime(year: 2024, month: 9, day: 1),
  )[
    - Research and Build C software for Precedence Constrained Knapsack (PCKP, scheduling optimization)
    - Profile and optimize software to meet production performance requirements (pthreads, custom hash table)
    - Write tests using Meson (Unit Tests, C) and NixOS testing framework (Integration Tests, Nix)
  ]

  #work-heading(
    "Open Source Software Maintainer",
    link("https://github.com/NixOS")[NixOS],
    "Remote",
    datetime(year: 2023, month: 11, day: 1),
    "Present",
  )[
    - Fixed various bugs in NixOS networking stack (DNS, Interfaces)
    - Write and maintain tests, packages, and NixOS Modules
  ]
]

#custom-title("Projects")[
  #project-heading(
    "namescale",
    stack: "Go, Nix",
    project-url: "https://github.com/sinanmohd/namescale",
  )[
    - Zeroconf Wildcard DNS for Tailscale, Headscale compatibility
  ]

  #project-heading(
    "redq",
    stack: "C, Go, Linux eBPF, Nix, SQL, TypeScript",
    project-url: "https://github.com/sinanmohd/redq",
  )[
    - Network observability and firewall using eBPF
    - Bandwidth and session based usage tracking per device, activity detection
    - DNS filtering, and MAC filtering
  ]

  #project-heading(
    "mpvsub",
    stack: "Lua",
    project-url: "https://git.sinanmohd.com/mpvsub",
  )[
    - Automagic subtitles for mpv, purpose made fuzzy matching algorithm
    - No API keys, or accounts needed, native implementation with minimal dependencies
  ]

  #project-heading(
    "npass",
    stack: "C, Nix, D-Bus, SQL",
    project-url: "https://github.com/sinanmohd/npass",
  )[
    - A passwordstore and Freedesktop.org Secret Service API implementation
    - Backward compatibility with existing unix passwordstore databases
  ]

  // #project-heading(
  //   "evanix",
  //   stack: "C, Nix",
  //   project-url: "https://git.sinanmohd.com/evanix",
  // )[
  //   - Pipelined Nix build scheduler
  //   - Resource-Aware build scheduling for maximizing throughput by intelligently selecting jobs with Precedence Constraints
  // ]

  #project-heading(
    "ctfbox",
    stack: "LXC/Containers, Lua, SSH, Nix/NixOS",
  )[
    - Declarative Ephemeral Linux environments for CUSAT CTF
    - Automated thin GNU/Linux environment provisioning with user sign up
  ]
]

#custom-title("Certifications")[
  #project-heading(
    "Hurricane Electric IPv6 Certification",
    stack: "he.net",
    project-url: "https://ipv6.he.net/certification/",
  )[]
]

#custom-title("Education")[
  #education-heading(
    link("https://cusat.ac.in/")[Cochin University of Science and Technology],
    "Kochi, India",
    "Bachelor's Degree", "Computer Science",
    datetime(year: 2021, month: 9, day: 1),
    datetime(year: 2025, month: 7, day: 1),
  )[]
]

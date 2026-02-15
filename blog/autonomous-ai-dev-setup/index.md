# Autonomous AI Product Dev Setup

*December 8, 2025*

## Multi-Host Console + Slack Prompt Relay

### Overview

Operate 10 Beelink GTi15 Ultra machines on autonomous tasks while controlling them from a single monitor, keyboard, and mouse. Achieve instant switching with an enterprise KVM over IP and receive actionable Slack notifications whenever any terminal session blocks for input — even for black-box programs whose output you don't control.

### Goals

- Single physical console for all hosts; near-instant switching.
- Slack alerts the moment any process awaits input; act via buttons or typed responses.
- Minimal intrusion: no changes to target programs (black-box support).
- Secure, reliable, and auditable.

## Hardware Topology

- 16-port KVM over IP
- Cabling
- Networking
- Power & stability
- Beelink GTi15 Ultra I/O alignment

## Software Architecture

### Components

1. Slack App
2. Command Server (Node.js)
3. Host Agent (Python, per machine)
4. Optional Admin box

### Data Flow

- Process output → Agent heuristic detection → Command server → Slack message (buttons + "Type...")
- Your choice in Slack → Command server → Agent reply endpoint → Agent writes choice to process stdin

### Prompt Detection Heuristics (no program changes needed)

- Lines ending with "?" or typical prompt markers like "(y/n)", "[Y/n]", ":", ">".
- Keywords: "enter", "input", "password", "continue", "press", "choice", "select", "confirm", "approve", "retry", "abort".
- Idle detection: no output for N seconds with a prompt-like tail.
- BEL (terminal bell) detection for urgent attention.

## Security & Reliability

- TLS on the command server; expose only HTTPS.
- HMAC shared secret between agents and server for event integrity.
- Slack signing secret verification for interactivity requests.
- Firewall host agent reply ports; limit to server's IP(s).
- Prompt deduplication and cooldown to avoid noise.
- Audit trail: Slack messages updated with final decision; server logs record events.
- Resilience.

## Deployment Steps

### 1) Hardware Setup

- Rack and power the KVM over IP and network switch; connect UPS.
- Connect each GTi15 Ultra to a KVM port via HDMI/DP + USB.
- Assign KVM ports 1–10 to hosts; label cables and ports.
- Configure KVM.

### 2) Slack App

- Create app in Slack → Enable Interactivity; set the Interactivity URL to your command server endpoint.
- Install to workspace; capture tokens.

### 3) Command Server (Node.js)

- Environment variables.
- Install and run.

### 4) Host Agent (Python)

- Environment variables per host.
- Install dependencies.
- Run workloads via the agent wrapper.

## Operations

- Run long-lived jobs through the agent wrapper so prompts are caught.
- Use KVM hotkeys (F1–F10) for instant local switching; use KVM web client links in Slack to jump remotely.
- In Slack: respond to prompts.
- Logging and audits.

## Tuning & Edge Cases

- Adjust PROMPT_IDLE_SECS for more/less sensitivity.
- Expand PROMPT_KEYWORDS to match your common workflows.
- Password prompts: prefer manual console via KVM or secure typed modal with limited retention.
- GUI dialogs: heuristics won't trigger; use KVM to click through.
- High-refresh video modes (HDR/VRR) may not be preserved by all KVMs; verify model capabilities if needed.

## Shopping List

- Enterprise 16-port IP-KVM (HDMI or DP, 4K60, USB HID, EDID lock).
- 10x HDMI 2.0 or DP 1.4 cables (identical make/model).
- 10x USB A-to-B cables for KVM HID.
- Managed Ethernet switch (24–48 ports; optional 10G uplink).
- 10x Cat6a/Cat7 patch cables.
- UPS sized for KVM + switch.

## Next Steps

- Confirm video standard (HDMI vs DP) and target resolution; procure the KVM model accordingly.
- Deploy the command server (TLS) and Slack app; validate interactive flows.
- Install the agent on each GTi15 Ultra; map KVM ports; test with a synthetic prompt.
- Iterate heuristics and cooldowns; add any custom keywords that match your workflows.

---

© 2026 Hunter Hodnett

- [GitHub](https://github.com/hunterchristian)
- [LinkedIn](https://linkedin.com/in/hunterhodnett)

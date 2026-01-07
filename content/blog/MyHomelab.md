---
Title: My Homelab
Subtitle: A Learning Journey in Self-Hosting and Infrastructure
Date: 2025-12-31T06:00:00.000Z
---

# My Homelab

I started this journey because I was working on my own web app. While developing my app, I wanted to be able to use it even when my PC was powered off. So I dug up an old laptop and loaded Fedora Server onto it. With the help of **Podman**, I could connect to the app from anywhere on the LAN and experiment with it. Adding automation to push the latest image to the server and having the server update itself, I quickly gained a liking for hosting apps locally. **Eventually**, I was using all of the laptop’s resources, so I found an old, beat-up **Dell tower**, cleaned it up, and installed **RHEL**.

This post isn’t a showcase of a perfect homelab — it’s a snapshot of where I am *right now* and what I’ve learned building it. Every choice here exists because something else **broke**, felt limiting, or taught me a better way to do things.

I use this homelab as a learning platform: for Linux system administration, containers, virtualization, networking, and the kinds of trade-offs you only really understand once you’re running services 24/7.

## Hardware

At the core of the lab is a single always-on server, a Dell XPS 8900 from 2016.

Specs:

- Intel Core i7
- 8 GB RAM
- One damaged Ethernet port (which limited initial networking experiments)
- A new *working* network card
- 1 TB hard drive

**Lessons learned:**

- Boring hardware is reliable hardware. Avoid cutting corners on RAM and CPU.
- Power consumption matters when running a lab 24/7.
- Repurposing old machines can teach a lot about limitations and optimizations.
- Hardware quirks (like the damaged Ethernet port) teach patience and creative problem-solving when experimenting with networking and connectivity.

## Operating System

### RHEL

The host OS is **Red Hat Enterprise Linux (RHEL)**. I chose RHEL for a few reasons:

- Rock-solid stability
- Enterprise-style tooling and defaults
- Forces me to learn systems administration the “serious” way
- Cockpit web interface

**Lessons learned:**

- Enterprise OSes may feel restrictive at first, but they teach you discipline in system management.
- Package management, SELinux, and systemd conventions can save you headaches later.

## Software Architecture

I separate concerns using **containers for services** and **virtual machines for isolation-heavy workloads**. This hybrid approach gives me flexibility without overloading one abstraction.

### Containers (Podman)

All containers run via **Podman**, not Docker. Rootless containers and tight systemd integration were the main selling points.

#### Dashy

- Centralized dashboard and quick access to services.
- **Lesson learned:** A simple dashboard saves mental overhead when juggling multiple services.

#### Uptime Kupa

- Tracks service availability.
- **Lesson learned:** Monitoring early prevents long debugging sessions when something silently fails.

#### Pi-hole

I added Pi-hole mainly to solve a small but constant annoyance: remembering and typing local IP addresses just to reach services. By running my own DNS, I could give services human-readable names instead.

- Local DNS for homelab services
- Ad and tracker blocking as a side benefit
- **Lesson learned:** Small quality-of-life improvements compound quickly in a homelab.

### Virtual Machines

Some workloads deserve stronger isolation or a full OS environment. For those, I use virtual machines.

#### Gitea

- Personal Git hosting.
- **Lesson learned:** Running your own Git server teaches backup strategies, user management, and repo organization.

#### “Dreaming City” VM (Home Services)

- Hosts most user-facing services in organized pods.

##### Pods

- **Nextcloud + OnlyOffice** – file syncing & collaboration
- **Jellyfin** – media streaming
- **FreshRSS** – RSS aggregation
- **Wiki.js** – documentation
- **Portainer** – container management

**Lesson learned:** Grouping services into pods improves clarity and makes upgrades much safer.

#### Minecraft Server

I added a Minecraft server mostly for fun, but it quickly turned into a learning exercise. The server is resource-hungry enough that I need to suspend a few other services when it’s running.

- Dedicated VM to isolate performance impact
- Easy snapshotting before changes
- **Lesson learned:** Resource limits become very real once you start mixing "fun" workloads with critical services.

#### Code VM

- Sandbox for development and experimentation.
- **Lesson learned:** A disposable environment encourages experimentation without fear.

## Networking

Networking is intentionally explicit—no magic, no surprises.

### VM Bridge

I wanted each virtual machine to have its own dedicated IP address on my LAN. The solution was a network bridge, which sounds simple in hindsight—but took several broken network configs to fully understand.

- VMs appear as first-class devices on the network
- Easier access and service discovery
- **Lesson learned:** Networking concepts don’t really stick until you break them and fix them a few times.

### Container Bridge

Some containers (like Pi-hole) work better when they have their own IP address. To support this, I added a separate bridge for containers.

- Clear separation between host, VMs, and containers
- More predictable networking behavior
- **Lesson learned:** Explicit networking beats "it just works" when debugging complex setups.

## Reflection

- Separation of concerns: host vs VM vs container is worth the upfront complexity.
- Snapshots and backups are your best friends.
- Learning by breaking things is more effective than passive reading.
- A homelab grows with you; each problem teaches a lesson.

## What’s Next

Future improvements I’m considering:

- Automated backups and offsite sync
- Enhanced monitoring and alerting
- Infrastructure as Code for VM and container definitions
- Documentation-first changes using Wiki.js

Building a homelab is never truly finished. It’s a living project, just like learning itself.

Go break something,

-Cameron

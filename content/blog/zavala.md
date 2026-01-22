---
title: Zavala
subtitle: my home server
date: 2026-01-19
id: 4
---

# Zavala

In a previous post about my home lab, I introduced the Dell XPS 8900 that acts as my main server, **Zavala**. This machine has become the backbone of my setup, handling virtualization, containers, networking experiments, and general self-hosting. Over time, it has evolved from “just another server” into a place where I can experiment with tools and workflows that feel closer to real-world production systems.

---

## Red Hat Enterprise Linux

When I first got Zavala up and running, my plan was to use **Fedora Server**, just like the server it replaced. While researching alternatives, I learned that **Red Hat offers a free Developer Subscription**, which includes a limited number of RHEL licenses for personal and non-production use. Since this lab is primarily for learning and experimentation, it seemed like a good opportunity to try RHEL in a more realistic, enterprise-style environment.

In practice, RHEL isn’t drastically different from Fedora Server. Both ship with **Cockpit** and its ecosystem of management tools, which made the transition fairly smooth. The biggest difference I noticed early on was around **package management and software availability**.

RHEL is built around **RPM packages** and traditionally uses **YUM (Yellow Dog Updater, Modified)** as its package manager, while Fedora uses **DNF (Dandified YUM)** by default. Although DNF is technically the successor to YUM, RHEL’s repositories are intentionally conservative. That stability comes at a cost: some packages that are readily available on Fedora simply aren’t included out of the box on RHEL.

This caused a few issues at first, especially when I tried to install tools that are common in hobbyist or home lab environments but aren’t officially supported in RHEL’s base repositories.

---

## EPEL (Extra Packages for Enterprise Linux)

Fortunately, there’s a well-established solution: **EPEL (Extra Packages for Enterprise Linux)**.

EPEL is a community-maintained repository provided by the Fedora Project that supplies additional packages for RHEL and compatible distributions. These packages aren’t part of Red Hat’s official repositories, but they’re built to integrate cleanly with Enterprise Linux systems and follow similar packaging standards.

Once EPEL was enabled, RHEL immediately felt much less restrictive. Many of the tools I needed but couldn’t previously find were suddenly available, which significantly reduced the friction of using RHEL in a home lab setting.

The setup process was straightforward, though it does involve one RHEL-specific prerequisite. I followed the official EPEL \[getting started\](<https://docs.fedoraproject.org/en-US/epel/getting-started/>) documentation and enabled the required repository before installing the EPEL release package:

```
subscription-manager repos --enable codeready-builder-for-rhel-10-$(arch)-rpms && \
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm
```

After that, I was able to install tools such as an older version of Java for my Minecraft server, along with utilities like **btop**, without any major issues.

---

## Cockpit as the Control Center

If RHEL provides the enterprise-grade foundation for Zavala, **Cockpit** is what makes it practical to run day to day in a home lab without sacrificing that enterprise feel.

Cockpit acts as a web-based control panel for the entire system and covers most routine administration tasks. It’s one of the main reasons I felt comfortable moving from Fedora Server to RHEL, since it reduced the need to constantly manage the system purely through the command line.

### Virtual Machines

Using Cockpit’s virtualization interface, I can:

- Create and manage KVM virtual machines
- Upload and manage ISO images
- Adjust CPU, memory, and storage allocations
- Start, stop, and access VM consoles directly from the browser

For basic VM management, this works very well. However, it can feel limiting compared to managing libvirt directly or using more advanced tooling. Some configuration options are hidden or difficult to reach, and more complex networking setups often require dropping down to the terminal.

### Containers

Cockpit’s container integration makes it easy to:

- Run and manage Podman containers
- Inspect logs and resource usage
- Start and stop services without SSHing into the host

For simple containers and single-service workloads, this is extremely convenient. As container setups grow more complex—multiple networks, volumes, or compose-like workflows—Cockpit starts to feel more like a monitoring interface than a full management solution.

### Networking

Cockpit also provides a graphical interface for managing networking:

- Creating and managing bridges
- Assigning interfaces to virtual machines
- Inspecting network configuration

This is especially useful when setting up isolated networks for testing or experimentation. That said, networking is one of the areas where Cockpit can be frustrating. Certain advanced configurations are difficult or impossible to express in the UI, and error messages can be vague when something goes wrong.

---

## Friction and Missing Features

While Cockpit is powerful, there are a few recurring pain points:

- Limited visibility into advanced libvirt and Podman options
- Networking configuration that can feel opaque
- UI workflows that don’t always map cleanly to the underlying tools

I often find myself starting a task in Cockpit and finishing it in the terminal. This isn’t necessarily a downside, but it does highlight areas where Cockpit could grow, especially for more experienced users.

---

## Final Thoughts

Running RHEL on Zavala has been a valuable learning experience. Compared to Fedora, it feels more rigid, but also more deliberate. With EPEL enabled and Cockpit acting as the primary interface, it strikes a solid balance between enterprise realism and home lab flexibility.

In future posts, I plan to dive deeper into specific setups on Zavala, including VM networking experiments, containerized services, and the ways I’ve worked around Cockpit’s limitations in day-to-day use.

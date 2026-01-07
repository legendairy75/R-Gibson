---
title: 3 Things I Learned
subtitle: Week 1 – Debugging, Tunnels, and Small Wins
date: 2026-01-07
---
## 3 Things I Learned This Week Running My Own Servers

This week was one of those “nothing looks done but everything changed” weeks in my homelab. A lot broke, a lot confused me, and a few things actually went right. Instead of pretending it was clean and polished, here are three real things I learned while running my own servers.

---

### 1. Cloudflare Tunnel is not magic

I’ve been running Nextcloud and OnlyOffice together for a while, and everything worked fine — until I added Nextcloud to my Cloudflare Tunnel.

After that, the OnlyOffice extension just… stopped working.

I tried:

- Putting OnlyOffice and Nextcloud on the same network

- Moving OnlyOffice into its own pod

- Putting OnlyOffice inside the Nextcloud pod

- Rebuilding things more times than I want to admit

Nothing fixed it.

What I learned is that Cloudflare Tunnel changes the networking assumptions your containers make about each other. Things that worked perfectly on an internal LAN suddenly don’t behave the same once traffic is being proxied, even if everything looks reachable.

It was frustrating — but also a reminder that “secure and exposed to the internet” is a completely different environment than “it works on my network.”

### 2. Self-hosting is 30% setup, 70% debugging

When I added Gitea to my tunnel, cloning over SSH immediately broke.

It turned out Gitea was still advertising its private LAN IP instead of my public domain. So every clone command it gave me was technically correct — just completely unreachable from the outside world.

The fix wasn’t hard, but it took a while to realize what was even wrong:
I had to modify Gitea’s configuration to make it use the public domain name instead of the internal address.

This was a good reminder that:

> Self-hosting is less about installing software and more about understanding what assumptions that software is making.

Once you change the environment, you inherit all of those assumptions — whether you know they exist or not.

### 3. Progress doesn’t always look like productivity

One bright spot this week: I found a project called Woogle.

I spun it up in a container on my desktop just to test it, and it worked immediately — clean, fast, and exactly what I was hoping for. I’ll be adding it into the homelab soon.

It’s a small win, but it mattered. After a week of debugging, seeing something “just work” was a reminder that I am making progress — even when most of that progress looks like troubleshooting instead of shiny dashboards.

---

Some weeks everything just breaks. Others, something works for five minutes before breaking again. Either way, if you’re learning, you’re winning — even if it doesn’t feel like it.

Go break something,

-Cameron
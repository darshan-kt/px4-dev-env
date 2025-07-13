
---

### 📥 Quick Start for Users

````markdown
# 🚀 Getting Started with PX4 Dev Environment

This repository provides a ready-to-use PX4 development environment using Docker + VSCode DevContainers.

---

## ✅ Prerequisites

Make sure you have the following installed on your system:

- [Docker](https://www.docker.com/products/docker-desktop) (version 20.10+)
- [Visual Studio Code](https://code.visualstudio.com/)
- VSCode extension: **Remote - Containers**
- (Optional) X11 support (for Gazebo GUI, e.g. XQuartz on macOS)

---

## 📦 Clone This Repository

Use `--recurse-submodules` to clone PX4-Autopilot along with the environment:

```bash
git clone --recurse-submodules https://github.com/darshan-kt/px4-dev-env.git
cd px4-dev-env
````

If you forget `--recurse-submodules`, run this after cloning:

```bash
git submodule update --init --recursive
```

---

## 🧠 What's Inside

```
px4-dev-env/
├── PX4-Autopilot/        # PX4 flight stack (Git submodule)
├── docker/               # Dockerfile for dev environment
├── .devcontainer/        # VSCode container config
├── Makefile              # Helper commands (used *inside* container)
└── README.md             # You're here!
```

---

## 🖥️ Open in VSCode

```bash
code .
```

Then press:

```text
F1 → Remote-Containers: Reopen in Container
```

VSCode will:

* Build the Docker image (from `docker/Dockerfile`)
* Mount your PX4 code into the container
* Set up the development environment (toolchain, Python, CMake, etc.)

---

## 🧪 Building and Testing PX4 (Inside the Container)

Once you're inside the container terminal, run:

```bash
make px4-build          # Build PX4 SITL
make px4-gazebo         # Run PX4 with Gazebo simulator
make px4-clean          # Clean build artifacts
```

---

## 🔁 Git Workflow (Inside the Container)

The container sees your host files directly — so you can commit changes like normal:

```bash
cd /workspaces/PX4-Autopilot
git checkout -b my-feature
# Make changes...
git add .
git commit -m "Add new flight pattern"
git push origin my-feature
```

Or use helper shortcuts:

```bash
make git-status
make git-push BRANCH=my-feature
```

---

## 📌 Notes

* Gazebo will launch if X11 forwarding is configured correctly on your system.
* The build environment is based on Ubuntu 20.04 with Gazebo Classic 11.
* You can modify or add your own PX4 apps, modules, and missions.

---

## 🙌 Contributing

Feel free to fork and modify this environment for your own robotics, drone, or simulation projects.

---

Happy flying! 🛸
Maintainer: **Darshan K T**

```

---

Let me know if you'd like:
- This customized with your actual GitHub repo URL
- A template version others can clone/fork
- A one-liner badge-style header (`DevContainer Ready`, `Dockerized PX4`, etc.) for GitHub flair
```

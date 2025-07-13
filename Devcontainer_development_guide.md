
---

### 📄 `README.md` – DevContainer-Based PX4 Development Environment

````markdown
# PX4-Autopilot DevContainer Environment

This repository provides a clean, Docker-based development environment for working with [PX4-Autopilot](https://github.com/PX4/PX4-Autopilot), powered by **VSCode DevContainers**. It enables consistent development, CI-friendly workflows, and out-of-the-box support for building and simulating PX4 via Gazebo.

---

## 🧠 What Is a DevContainer?

A **DevContainer** is a way to define and version-control your development environment using:

- A `Dockerfile` (your actual toolchain)
- A `.devcontainer/devcontainer.json` (VSCode config)

VSCode uses this to **build, launch, and mount your project** into a Docker container, pre-configured with extensions and settings.

---

## ❓ Why Use DevContainers?

| Benefit | Description |
|--------|-------------|
| 🔁 Reproducible | Everyone on your team gets the same working environment |
| 🧪 Isolated | Keeps PX4 toolchains out of your host system |
| ⚙️ Pre-configured | Extensions, debuggers, CMake paths all setup |
| 💻 Host-integrated | Works transparently with Git, your files, and VSCode |
| 🔋 CI-compatible | Use the same Dockerfile in GitHub Actions, GitLab CI, etc. |

---

## ⚖️ DevContainer vs Traditional `docker run`

| Question | DevContainer | Manual Docker |
|----------|--------------|----------------|
| Host file changes reflect inside? | ✅ Yes |
| Container file changes reflect on host? | ✅ Yes |
| Git works normally? | ✅ Yes |
| IDE/editor support? | ✅ Fully integrated |
| Reproducible environment? | ✅ Yes | ❌ Manual setup required |
| Onboarding time | 🟢 Minutes | 🔴 Varies by person/system |

> DevContainers are built on top of Docker, but optimized for interactive development in VSCode.

---

## 🚀 Setup Instructions

This guide assumes you want to use PX4 inside a devcontainer with VSCode.

### 1. Clone This Project

```bash
git clone https://github.com/PX4/PX4-Autopilot.git --recursive
mkdir px4-dev-env && cd px4-dev-env
mv ../PX4-Autopilot .  # Move PX4 into this workspace
````

**Structure:**

```
px4-dev-env/
├── PX4-Autopilot/        # PX4 source (cloned)
├── docker/               # Dockerfile for PX4 dev
├── .devcontainer/        # DevContainer VSCode config
├── Makefile              # Helper CLI for docker/git
└── README.md             # This file
```

---

### 2. Add Dockerfile

In `docker/Dockerfile`, use an Ubuntu 20.04-based PX4 environment with Gazebo and all PX4 deps.
You can reuse the one in this repo or [from this example](#).

---

### 3. Add `.devcontainer/devcontainer.json`

```json
{
  "name": "PX4 Dev",
  "build": {
    "dockerfile": "docker/Dockerfile",
    "context": ".."
  },
  "workspaceFolder": "/workspaces/PX4-Autopilot",
  "remoteUser": "px4",
  "extensions": [
    "ms-vscode.cpptools",
    "ms-vscode.cmake-tools",
    "ms-python.python"
  ],
  "mounts": [
    "source=${localWorkspaceFolder}/PX4-Autopilot,target=/workspaces/PX4-Autopilot,type=bind"
  ],
  "runArgs": [
    "--privileged",
    "--env=DISPLAY=${env:DISPLAY}",
    "--env=QT_X11_NO_MITSHM=1",
    "--volume=/tmp/.X11-unix:/tmp/.X11-unix:rw",
    "--volume=${env:HOME}/.Xauthority:/home/px4/.Xauthority:rw"
  ]
}
```

| Key               | What it Does                             | Example                        |
| ----------------- | ---------------------------------------- | ------------------------------ |
| `name`            | Dev container display name               | `PX4 Dev`                      |
| `build`           | Where and how to build the image         | Dockerfile path, build context |
| `workspaceFolder` | Folder opened by VSCode inside container | `/workspaces/PX4-Autopilot`    |
| `remoteUser`      | Linux user inside container              | `px4`                          |
| `extensions`      | Pre-installed VSCode plugins             | C++, CMake, Python             |
| `mounts`          | Folder binds from host                   | For source sharing             |
| `runArgs`         | Docker runtime args                      | For GUI / Gazebo / permissions |


---

### 4. Build and Launch DevContainer

1. Open `px4-dev-env/` in VSCode
2. Press `F1` → `Remote-Containers: Reopen in Container`
3. Wait for it to build and open inside the container
4. Use the terminal inside VSCode to compile PX4:

```bash
cd /workspaces/PX4-Autopilot
make px4_sitl_default gazebo
```

---

## 🧪 Test Your Build

Run:

```bash
make px4_sitl_default
```

Expected:

* PX4 compiles successfully
* You get a SITL shell (or Gazebo opens, if GUI enabled)

---

## 🔁 Git Workflow

Because your PX4 folder is mounted, Git works **identically** inside or outside the container.

### ✅ Preferred (inside container)

```bash
cd /workspaces/PX4-Autopilot
git checkout -b my-feature
git add .
git commit -m "Add my feature"
git push origin my-feature
```

### ✅ Alternative (on host)

```bash
cd px4-dev-env/PX4-Autopilot
git status
```

> Just don't mix both environments at the same time if using different editors/tools.

---

## 🔄 Git Commands via Makefile (Optional)

You can define helper targets in `Makefile`:

```makefile
git-status:
	cd PX4-Autopilot && git status

git-push:
	cd PX4-Autopilot && git push origin $(BRANCH)
```

Then run:

```bash
make git-push BRANCH=my-feature
```

---


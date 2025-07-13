# -------------------------------
# PX4 Build Targets
# -------------------------------

.PHONY: px4-build
px4-build:
	make px4_sitl_default

.PHONY: px4-gazebo
px4-gazebo:
	make px4_sitl_default gazebo

.PHONY: px4-clean
px4-clean:
	make clean

# -------------------------------
# Git Helper Targets
# -------------------------------

.PHONY: git-status
git-status:
	git status

.PHONY: git-branch
git-branch:
	git branch

.PHONY: git-push
git-push:
ifndef BRANCH
	$(error Usage: make git-push BRANCH=branch-name)
endif
	git push origin $(BRANCH)

.PHONY: git-pull
git-pull:
ifndef BRANCH
	$(error Usage: make git-pull BRANCH=branch-name)
endif
	git pull origin $(BRANCH)

.PHONY: git-log
git-log:
	git log --oneline --graph --decorate --all

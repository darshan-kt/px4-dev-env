# Path to PX4 source
PX4_DIR := PX4-Autopilot

.PHONY: px4-build px4-gazebo px4-clean git-status git-push git-pull

px4-build:
	cd $(PX4_DIR) && make px4_sitl_default

px4-gazebo:
	cd $(PX4_DIR) && make px4_sitl_default gazebo

px4-clean:
	cd $(PX4_DIR) && make clean

git-status:
	cd $(PX4_DIR) && git status

git-push:
ifndef BRANCH
	$(error Usage: make git-push BRANCH=my-branch)
endif
	cd $(PX4_DIR) && git push origin $(BRANCH)

git-pull:
ifndef BRANCH
	$(error Usage: make git-pull BRANCH=my-branch)
endif
	cd $(PX4_DIR) && git pull origin $(BRANCH)

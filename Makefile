python3=python3.6
venv_dir=local/venv

src_dir=hll
src_files=$(shell find $(src_dir) -type f -name '*.cxx' -o -name '*.h' -o -name '*.pxd' -o -name '*.pyx')

all: $(venv_dir)/packages-installed check

build: $(venv_dir)/packages-installed

ready: build

mrproper:
	rm -rfv .cache build *.egg-info $(venv_dir)
	rm -rfv $(src_dir)/*.so
	rm -rfv $(src_dir)/*.cpp
	rm -rfv $(src_dir)/__pycache__

$(venv_dir)/packages-installed: setup.py $(src_files) Makefile requirements.txt
	test -d $(venv_dir) || $(python3) -m venv $(venv_dir)
	$(venv_dir)/bin/pip install -U pip wheel
	$(venv_dir)/bin/pip install -r requirements.txt
	$(venv_dir)/bin/pip install -U colorama
	# $(venv_dir)/bin/pip install -e .
	$(venv_dir)/bin/python3 setup.py build_ext --inplace
	touch $(venv_dir)/packages-installed


check:
	# g++ -g -std=c++17 -O4 -Wall -Wextra  hll/murmur.cxx tests/test_serialization.cpp -o test_serialization && ./test_serialization
	# rm test_serialization
	g++ -g -std=c++17 -O4 -Wall -Wextra  hll/murmur.cxx tests/test_count.cpp -o test_count && ./test_count
	rm test_count


.PHONY: build check run mrproper

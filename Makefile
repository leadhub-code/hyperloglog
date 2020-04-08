python3=python3
venv_dir=local/venv

src_dir=pyhllpp
src_files=$(shell find $(src_dir) -type f -name '*.cpp' -o -name '*.h' -o -name '*.pxd' -o -name '*.pyx')

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
	$(venv_dir)/bin/python3 setup.py build_ext --inplace
	$(venv_dir)/bin/pip install -e .
	touch $(venv_dir)/packages-installed

check: $(venv_dir)/packages-installed
	g++ -g -std=c++14 -O4 -Wall -Wextra pyhllpp/cpp_src/*.cpp tests/test_serialization.cpp -o test_serialization && ./test_serialization
	rm test_serialization
	g++ -g -std=c++14 -O4 -Wall -Wextra pyhllpp/cpp_src/*.cpp tests/test_count.cpp -o test_count && ./test_count
	rm test_count
	$(venv_dir)/bin/python3 tests/test_serialization.py

.PHONY: build check run mrproper

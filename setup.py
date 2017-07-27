from setuptools import setup, find_packages, Extension
from Cython.Build import cythonize
from glob import glob

import os
os.environ["CC"] =  "g++"
os.environ["CXX"] = "g++"

extensions = [
    Extension(
        'pyhllpp',
        glob('hll/*.pyx') + glob('hll/*.cxx'),
        language='c++',
        extra_compile_args=['-std=c++14', '-O4'],
    ),
]

setup(
    name='pyhllpp',
    version='0.0.1',
    author='Radovan Cerveny',
    author_email='songman@leadhub.co',
    packages=find_packages(exclude=['doc', 'tests']),
    install_requires=[],
    ext_modules=cythonize(extensions),
    )

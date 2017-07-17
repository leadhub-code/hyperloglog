from setuptools import setup, find_packages, Extension
from Cython.Build import cythonize
from glob import glob

extensions = [
    Extension(
        'pyhll',
        glob('hll/**/*.pyx', recursive=True) + glob('hll/**/*.cxx', recursive=True),
        language='c++',
        extra_compile_args=['-std=c++17', '-O4'],
    ),
]

setup(
    name='pyhll',
    version='0.0.1',
    author='Radovan Cerveny',
    author_email='songman@leadhub.co',
    packages=find_packages(exclude=['doc', 'tests']),
    install_requires=[],
    ext_modules=cythonize(extensions),
    )

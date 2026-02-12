#!/bin/bash

# Descarga e instala auto-cpufreq
wget https://github.com/AdnanHodzic/auto-cpufreq/archive/refs/tags/v2.6.0.zip
7z x auto-cpufreq-2.6.0.zip && cd auto-cpufreq-2.6.0
sudo ./auto-cpufreq-installer
sudo auto-cpufreq --install

cd ..

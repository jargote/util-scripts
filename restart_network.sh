#!/bin/bash

# Restart network adapter.
sudo ifdown eth0
sudo ifup eth0

#!/bin/bash
cp -r assets linux-aarch64/assets
cp -r assets linux-amd64/assets
cp -r assets linux-arm/assets
cp -r assets windows-amd64/assets

cp settings.json linux-aarch64
cp settings.json linux-amd64
cp settings.json linux-arm
cp settings.json windows-amd64

cp gamesave.json linux-aarch64
cp gamesave.json linux-amd64
cp gamesave.json linux-arm
cp gamesave.json windows-amd64

cp level-editor-save.json linux-aarch64
cp level-editor-save.json linux-amd64
cp level-editor-save.json linux-arm
cp level-editor-save.json windows-amd64

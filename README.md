Certainly! Below is a basic template for a README file. You can customize it further based on your project specifics.

# Flashcard App

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Folder Structure](#folder-structure)
- [Getting Started](#getting-started)
  - [For Linux](#for-linux)
- [Usage](#usage)

## Introduction

The Flashcard App is a simple command-line application for creating and reviewing flashcards. It allows users to create new flashcards manually or from a JSON file, review existing flashcards, and save flashcard sets.

## Features

- Create new flashcards manually or from a JSON file
- Review existing flashcards interactively
- Save flashcard sets as JSON files

## Folder Structure

The project follows the following folder structure:

- **CLI**: Contains the Swift source code for the command-line application.
  - **FlashcardApp.swift**: Main application file.
  - **Resources**: Placeholder for saved JSON files.

## Getting Started

### For Linux

1. **Install Swift:**
   - Download Swift for Linux from [Swift.org](https://swift.org/download/).
   - Set up your environment and ensure the Swift binaries are in your system's PATH.

2. **Clone the Repository:**
   ```bash
   git clone git@github.com:Leramir1/flashcard-app.git
   cd flashcard-app
   ```

3. **Compile the Code:**
   ```bash
   swiftc Sources/CLI/FlashcardApp.swift
   ```

4. **Run the Executable:**
   ```bash
   ./FlashcardApp
   ```

### Usage

- Choose the "Create new flashcards" option to add new flashcards to your sets.
- Choose the "Review existing flashcards" option to review your flashcards interactively.
- Choose the "Exit" option to exit the Flashcard App.

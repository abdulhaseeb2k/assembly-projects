# Tic-Tac-Toe in x86 Assembly

This repository contains a simple Tic-Tac-Toe game implemented in x86 assembly language. The game allows two players to compete against each other, taking turns to mark their choices on a 3x3 grid. The implementation is designed to run on Windows using MASM and Visual Studio.

## Features
- Two-player gameplay on a single machine.
- Simple text-based user interface.
- Checks for win conditions and draws.
- Customizable player names.

## Prerequisites
To compile and run this game, you will need:
- Visual Studio (recommended: Visual Studio 2019 or later)
- Microsoft Macro Assembler (MASM) module installed with Visual Studio

## Setup and Compilation
1. **Install Visual Studio**: Ensure that Visual Studio is installed with the Desktop development with C++ workload, which includes support for MASM.

2. **Clone the Repository**: Clone this repository to your local machine using:
   ```bash
   git clone https://github.com/your-github-username/tic-tac-toe-asm.git](https://github.com/haseebbutt085/TicTacToe-Assembly-X86.git


3. **Open the Project:**
    Launch Visual Studio.
    Navigate to File > Open > Project/Solution and select the .sln file located in your cloned repository.
    Configure MASM Build Customizations:
    Right-click on the project in the Solution Explorer.
    Select Build Dependencies > Build Customizations....
    Check the box for masm and click OK.
    Build the Project:
    Right-click on the project in the Solution Explorer.
    Select Build.

4. **Running the Game**
  After building the project, you can run the game directly from Visual Studio by pressing Ctrl+F5. This starts the game without debugging.

5. **Gameplay**
  The game starts by displaying an introduction and prompting each player to enter their name.
  A random toss decides which player goes first.
  Players take turns selecting positions on the board by entering numbers between 1 and 9.
  The game checks for a win or a draw after each move.

# Contributions
  Contributions are welcome! Please fork this repository, make your changes, and submit a pull request.

# License
  This project is open source and available under the MIT License.

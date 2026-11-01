# Advanced Algorithms formalization

`AdvancedHashing.v` contains the Rocq notes for Lecture 6: Advanced Hashing.
`Exercise06.v` contains the work on Exercise 6.
`_CoqProject` lists the source files and sets the logical namespace
`AdvancedAlgoFormalization`.

From the repository root, generate the build files and compile:

```bash
cd formalization
rocq makefile -f _CoqProject -o Makefile
make
```

After editing a proof, run `make` again. When adding a new `.v` file, list it
in `_CoqProject` and regenerate the Makefile with the command above.

To remove generated build artifacts:

```bash
make clean
```

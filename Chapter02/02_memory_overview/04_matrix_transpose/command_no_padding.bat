ncu -o transpose_no_padding ^
  --set full ^
  --section LaunchStats ^
  --section MemoryWorkloadAnalysis ^
  --section WarpStateStats ^
  --section SpeedOfLight ^
  --target-processes all ".\build\Release\matrix_transpose.exe"
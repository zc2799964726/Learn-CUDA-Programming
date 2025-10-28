ncu -o transpose_padding ^
  --set full ^
  --section LaunchStats ^
  --section MemoryWorkloadAnalysis ^
  --section WarpStateStats ^
  --section SpeedOfLight ^
  --target-processes all ".\build\Release\conflict_solved.exe"
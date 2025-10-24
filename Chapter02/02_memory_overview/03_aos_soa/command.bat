# 生成 `aos_nsys.qdrep`，可用 Nsight Systems GUI 打开。
nsys profile -o aos_nsys .\路径\aos.exe

# 生成文件：`aos_ncu.ncu-rep`
ncu -o aos_ncu --set full --target-processes all "D:\git\Learn-CUDA-Programming\Chapter02\02_memory_overview\03_aos_soa\build\Release\aos.exe"

# 必须用prof的命令
nvprof --analysis-metrics --export-profile aos_profile.nvprof .\build\Release\aos.exe 

# 导入
ncu --import aos_ncu.ncu-rep --export result --export-format html,json,sqlite -o aos_ncu_export
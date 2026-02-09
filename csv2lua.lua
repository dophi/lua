--[[ 加载表的代码
local table = {}

table[1] = { id=5, data="" }
table[2] = { id=6, data="" }

return table
]]
 
local function print_table(t)
	for k,v in pairs(t) do
		print(v)
	end
end

local function split_str(str, split_char)
    local sub_str_tab = {}
    while (true) do
        local pos = string.find(str, split_char)
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1)
        sub_str_tab[#sub_str_tab + 1] = sub_str
        str = string.sub(str, pos + 1, #str)
    end

    return sub_str_tab;
end


-- 读取配置到表中
local fistline = false
local filed_names = {}
local fileds_list = {}
local fileds_list_idx = 1
for line in io.lines("res/Character.csv") do
	if not fistline then
	 	fistline = true
	 	filed_names = split_str(line, ",")
	 	--print_table(filed_names)
	else
	    local fileds = {}
	    fileds = split_str(line, ",")
	    fileds_list[fileds_list_idx] = fileds
	    fileds_list_idx = fileds_list_idx + 1
	   	print("read line")
	   	--print_table(fileds)
	end
end

-- 把表存成一个lua文件的形式
local wf = io.output("res/cfg.lua")
wf:write("--表字段：")
for k,v in pairs(filed_names) do
	wf:write(v, ",")	
end
wf:write("\n")

wf:write("local cfg = {}\n")
for i,v in pairs(fileds_list) do
	wf:write("cfg[0] = {")
	for idx,filed in pairs(v) do
		wf:write(filed_names[idx], "=", filed, ",")
	end
	wf:write("}\n")
	print("line")
end
wf:close()


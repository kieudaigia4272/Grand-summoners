gg.setRanges(gg.REGION_C_ALLOC)

local XGCK = -1

-- =========================================
-- CORE UTILS
-- =========================================

local function clear()
    gg.clearResults()
end

-- Safe search
local function safeSearch(search, flags, refine, limit)

    clear()

    gg.searchNumber(search, flags)

    if refine then
        gg.refineNumber(refine, flags)
    end

    return gg.getResults(limit or 300)
end

-- Chunk writer
local function batchWrite(tbl, chunkSize)

    if not tbl or #tbl == 0 then
        return
    end

    chunkSize = chunkSize or 120

    for i = 1, #tbl, chunkSize do

        local temp = {}

        for j = i, math.min(i + chunkSize - 1, #tbl) do
            temp[#temp + 1] = tbl[j]
        end

        gg.setValues(temp)
    end
end

-- Chunk freeze
local function batchFreeze(tbl, chunkSize)

    if not tbl or #tbl == 0 then
        return
    end

    chunkSize = chunkSize or 120

    for i = 1, #tbl, chunkSize do

        local temp = {}

        for j = i, math.min(i + chunkSize - 1, #tbl) do
            temp[#temp + 1] = tbl[j]
        end

        gg.addListItems(temp)
    end
end

-- =========================================
-- MENU
-- =========================================

function Main()

    local menu = gg.choice({
        '1. Full Art + Boost BE',
        '2. Instant Win',
        '3. Break Boss',
        '4. Kill Boss',
        '5. All Boss 0 HP',
        '6. All Creep 0 HP',
        '7. Mod Unit Damage',
        'Exit'
    }, nil, 'Becoming God')

    if menu == 1 then
        a1()

    elseif menu == 2 then
        a2()

    elseif menu == 3 then
        a3()

    elseif menu == 4 then
        a4()

    elseif menu == 5 then
        a5()

    elseif menu == 6 then
        a6()

    elseif menu == 7 then
        a7()

    elseif menu == 8 then
        Exit()
    end

    XGCK = -1
end

-- =========================================
-- FUNCTION 1
-- =========================================
function settime()
    -- 1. Tìm kiếm giá trị
    gg.clearResults()
    gg.searchNumber("433513380", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)

    -- Lấy danh sách kết quả (tối đa 3)
    local results = gg.getResults(3)
    local count = #results

    if count == 0 then
        gg.toast("Not found value func time")
    else
        -- 2. Duyệt trực tiếp và set giá trị
        for i = 1, count do
            local addr = results[i].address - 40
            
            -- Lấy giá trị hiện tại để cộng thêm 62.2
            local currentVal = gg.getValues({{address = addr, flags = gg.TYPE_FLOAT}})[1].value
            
            -- Set giá trị bằng gg.setValues (phải dùng bảng)
            gg.setValues({{address = addr, flags = gg.TYPE_FLOAT, value = currentVal + 62}})
        end
    end

    gg.clearResults()
end

function a1()

    -- 1. Tìm kiếm giá trị 1300901660
gg.clearResults()
gg.searchNumber("1300901660", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)

-- Lấy danh sách kết quả (tối đa 30 theo yêu cầu)
local count = gg.getResultsCount()
if count == 0 then
    gg.alert("Không tìm thấy giá trị!")
    os.exit()
end
local results = gg.getResults(30)

-- Chuẩn bị danh sách set giá trị (tối ưu hơn việc set từng cái một)
local toEdit = {}

-- 2. Kiểm tra điều kiện offset
for i = 1, #results do
    local addr = results[i].address
    
    -- Đọc giá trị tại offset -48 và -52 (Float)
    local val48 = gg.getValues({{address = addr - 48, flags = gg.TYPE_FLOAT}})[1].value
    local val52 = gg.getValues({{address = addr - 52, flags = gg.TYPE_FLOAT}})[1].value
    
    -- Kiểm tra nếu bằng 1
    if val48 == 1 and val52 == 1 then
        -- 3. Đưa vào danh sách cần ghi (không set ngay để tránh lag)
        table.insert(toEdit, {address = addr - 48, flags = gg.TYPE_FLOAT, value = 80})
        table.insert(toEdit, {address = addr - 52, flags = gg.TYPE_FLOAT, value = 80})
        table.insert(toEdit, {address = addr - 40, flags = gg.TYPE_FLOAT, value = 300})
    end
end

-- Thực hiện ghi dữ liệu một lần duy nhất
if #toEdit > 0 then
    gg.setValues(toEdit)
    gg.toast("Boosted 🔥 " .. (#toEdit / 3) .. " unit!")
else
    gg.toast("Error value code function boost")
end

gg.clearResults()
end

function a2()
-- =========================
-- FUNCTION 2 - INSTANT WIN (Tối ưu hóa: Không table, No Freeze, Trực diện)
-- =========================
clear()
    gg.searchNumber(
        "65793;65536;1~4D;16842752;-1;-1:512",
        gg.TYPE_DWORD
    )

    gg.refineNumber("1~4", gg.TYPE_DWORD)

    local r = gg.getResults(20)

    if #r > 0 then

        for i = 1, #r do
            r[i].value = 6
        end

        batchWrite(r)
    end
    settime()
    a4()
end

-- =========================================
-- FUNCTION 3
-- =========================================

function a3()
clear()
    -- 1. Tìm kiếm giá trị
gg.searchNumber("-1850219005", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)

local count = gg.getResultsCount()
if count == 0 then
    gg.toast("Mobs not found")
    os.exit()
end

local results = gg.getResults(20)
local edits = {}

-- 2. Kiểm tra offset -8 (Double > 20000)
for i = 1, #results do
    local addr = results[i].address
    local valDouble = gg.getValues({{address = addr - 8, flags = gg.TYPE_DOUBLE}})[1].value
    
    if valDouble > 20000 then
        -- 3. Đưa vào danh sách ghi
        -- Offset -8 thành -2000 (Double)
        table.insert(edits, {address = addr - 8, flags = gg.TYPE_DOUBLE, value = 100000})
        -- Offset +24 thành -2000 (Float)
        table.insert(edits, {address = addr + 24, flags = gg.TYPE_FLOAT, value = -2000})
    end
end

-- Thực hiện ghi một lần duy nhất
if #edits > 0 then
    gg.setValues(edits)
    gg.toast("Mobs break: " .. (#edits / 2))
else
    gg.toast("Not found value func 3")
    end
    clear()
end

-- =========================================
-- FUNCTION 4
-- =========================================

function a4()
clear()
    -- 1. Tìm kiếm giá trị
gg.searchNumber("-1850219005", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)

local count = gg.getResultsCount()
if count == 0 then
    gg.toast("Không tìm thấy giá trị!")
    os.exit()
end

local results = gg.getResults(20)
local edits = {}

-- 2. Kiểm tra offset -8 (Double > 20000)
for i = 1, #results do
    local addr = results[i].address
    local valDouble = gg.getValues({{address = addr - 8, flags = gg.TYPE_DOUBLE}})[1].value
    
    if valDouble > 20000 then
        -- 3. Đưa vào danh sách ghi
        -- Offset -8 thành -2000 (Double)
        table.insert(edits, {address = addr - 8, flags = gg.TYPE_DOUBLE, value = -2000})
        -- Offset +24 thành -2000 (Float)
        table.insert(edits, {address = addr + 24, flags = gg.TYPE_FLOAT, value = -2000})
    end
end

-- Thực hiện ghi một lần duy nhất
if #edits > 0 then
    gg.setValues(edits)
    gg.toast("Mobs killed: " .. (#edits / 2))
else
    gg.toast("Not found value func 4")
    end
    clear()
end

-- =========================================
-- FUNCTION 5
-- =========================================

function a5()

    clear()

    gg.searchNumber(
        "-1850219005D;289792896F::9",
        gg.TYPE_DWORD | gg.TYPE_FLOAT
    )

    gg.refineNumber("-1850219005", gg.TYPE_DWORD)

    local results = gg.getResults(100)

    if #results == 0 then
        gg.toast("No Boss Found")
        return
    end

    local freezeTbl = {}

    for i = 1, #results do

        local anchor = results[i].address

        freezeTbl[#freezeTbl + 1] = {
            address = anchor - 8,
            flags = gg.TYPE_DOUBLE,
            value = -100,
            freeze = true
        }

        freezeTbl[#freezeTbl + 1] = {
            address = anchor + 24,
            flags = gg.TYPE_FLOAT,
            value = -100,
            freeze = true
        }
    end

    batchWrite(freezeTbl)
    batchFreeze(freezeTbl)

    gg.toast("Boss Frozen")

    clear()
end

-- =========================================
-- FUNCTION 6
-- =========================================

function a6()

    clear()

    gg.searchNumber(
        "300000~60000000;90;1;1;1;1;1;1;3",
        gg.TYPE_DWORD
    )

    gg.refineNumber(
        "300000~60000000",
        gg.TYPE_DWORD
    )

    local t = gg.getResults(500)

    local patch = {}

    for i = 1, #t do

        local v = tonumber(t[i].value)

        if v and v > 300000 and v < 60000000 then

            patch[#patch + 1] = {
                address = t[i].address,
                flags = gg.TYPE_DWORD,
                value = 0,
                freeze = true
            }
        end
    end

    batchWrite(patch)
    batchFreeze(patch)

    gg.toast("All Boss Dead")
end

-- =========================================
-- FUNCTION 7
-- =========================================

function a7()

    local units = {
        [1] = 104047412,
        [2] = 103787212,
        [3] = 108097312,
        [4] = 108157412,
        [5] = 108137512,
        [6] = 103757512,
        [7] = 108357312,
        [8] = 108247312
    }

    local menu = gg.choice({
        '1. Platina',
        '2. Valeria',
        '3. Veldora',
        '4. Saitama',
        '5. Saito',
        '6. Rosetta',
        '7. Youmu',
        '8. Okarun',
        'Back'
    })

    if menu == 9 then
        return
    end

    local unit = units[menu]

    clear()

    gg.searchNumber(
        "107697512~108378112;2;112~125;5~7;-1;-1;-1;-1;-1",
        gg.TYPE_DWORD
    )

    gg.refineNumber(
        "107697512~108157412",
        gg.TYPE_DWORD
    )

    local t = gg.getResults(300)

    local patch = {}

    for i = 1, #t do

        patch[#patch + 1] = {
            address = t[i].address,
            flags = gg.TYPE_DWORD,
            value = unit
        }

        patch[#patch + 1] = {
            address = t[i].address + 92,
            flags = gg.TYPE_DWORD,
            value = 1094967296,
            freeze = true
        }

        patch[#patch + 1] = {
            address = t[i].address + 100,
            flags = gg.TYPE_DWORD,
            value = 2094967296,
            freeze = true
        }

        patch[#patch + 1] = {
            address = t[i].address + 104,
            flags = gg.TYPE_DWORD,
            value = 2094967296,
            freeze = true
        }
    end

    batchWrite(patch)
    batchFreeze(patch)

    gg.toast("Unit Mod Applied")

    clear()
end

-- =========================================
-- EXIT
-- =========================================

function Exit()
    os.exit()
end

-- =========================================
-- MAIN LOOP
-- =========================================

while true do

    if gg.isVisible(true) then
        XGCK = 1
        gg.setVisible(false)
    end

    if XGCK == 1 then
        Main()
    end

    gg.sleep(500)
end

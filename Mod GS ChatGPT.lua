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

function a1()

    local patch = {}

    -- SEARCH 1

    gg.searchNumber("2500", gg.TYPE_FLOAT)

    local r1 = gg.getResults(300)

    for i = 1, #r1 do

        patch[#patch + 1] = {
            address = r1[i].address - 60,
            flags = gg.TYPE_FLOAT,
            value = 300
        }

        patch[#patch + 1] = {
            address = r1[i].address - 68,
            flags = gg.TYPE_FLOAT,
            value = 80
        }
    end

    clear()

    -- SEARCH 2

    gg.searchNumber("2000;5D", gg.TYPE_FLOAT)

    gg.refineNumber("2000", gg.TYPE_FLOAT)

    local r2 = gg.getResults(300)

    for i = 1, #r2 do

        patch[#patch + 1] = {
            address = r2[i].address - 60,
            flags = gg.TYPE_FLOAT,
            value = 300
        }

        patch[#patch + 1] = {
            address = r2[i].address - 68,
            flags = gg.TYPE_FLOAT,
            value = 80
        }
    end

    batchWrite(patch)

    gg.toast("Boosted 🔥")
end

-- =========================================
-- FUNCTION 2
-- =========================================

function a2()

    clear()

    gg.searchNumber(
        "65793;65536;1~3D;16842752;-1;-1:512",
        gg.TYPE_DWORD
    )

    gg.refineNumber("1~3", gg.TYPE_DWORD)

    local r = gg.getResults(1000)

    if #r > 0 then

        for i = 1, #r do
            r[i].value = 6
        end

        batchWrite(r)
    end

    a4()
end

-- =========================================
-- FUNCTION 3
-- =========================================

function a3()

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

    local readTbl = {}
    local anchorMap = {}

    for i = 1, #results do

        local anchor = results[i].address
        local hpAddr = anchor - 8

        readTbl[#readTbl + 1] = {
            address = hpAddr,
            flags = gg.TYPE_DOUBLE
        }

        anchorMap[hpAddr] = anchor
    end

    local hpValues = gg.getValues(readTbl)

    local patch = {}

    for i = 1, #hpValues do

        local hp = tonumber(hpValues[i].value)

        if hp and hp > 30000 and hp < 999999999 then

            local anchor = anchorMap[hpValues[i].address]

            patch[#patch + 1] = {
                address = hpValues[i].address,
                flags = gg.TYPE_DOUBLE,
                value = 120000
            }

            patch[#patch + 1] = {
                address = anchor + 24,
                flags = gg.TYPE_FLOAT,
                value = -1000
            }
        end
    end

    batchWrite(patch)

    gg.toast("Bể cái mu nè ⛏️")

    clear()
end

-- =========================================
-- FUNCTION 4
-- =========================================

function a4()

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

    local readTbl = {}
    local shieldMap = {}

    for i = 1, #results do

        local anchor = results[i].address
        local hpAddr = anchor - 8

        readTbl[#readTbl + 1] = {
            address = hpAddr,
            flags = gg.TYPE_DOUBLE
        }

        shieldMap[hpAddr] = anchor + 24
    end

    local hpValues = gg.getValues(readTbl)

    local patch = {}

    for i = 1, #hpValues do

        local hp = tonumber(hpValues[i].value)

        if hp and hp > 30000 and hp < 999999999 then

            patch[#patch + 1] = {
                address = hpValues[i].address,
                flags = gg.TYPE_DOUBLE,
                value = -1009
            }

            patch[#patch + 1] = {
                address = shieldMap[hpValues[i].address],
                flags = gg.TYPE_FLOAT,
                value = -1000
            }
        end
    end

    batchWrite(patch)

    gg.toast("Allahu Akbar ✈🏢🏢 !")

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
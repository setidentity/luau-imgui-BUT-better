local sha = {}

local function u64_add(a, b)
    local low = (a[2] + b[2]) % 0x100000000
    local high = (a[1] + b[1] + math.floor((a[2] + b[2]) / 0x100000000)) % 0x100000000
    return {high, low}
end

local function u64_rotr(x, n)
    local h, l = x[1], x[2]
    if n == 0 then return x end
    if n >= 32 then
        n = n - 32
        h, l = l, h
    end
    local mask = (1 << n) - 1
    return {
        ((h >> n) | ((l & mask) << (32 - n))) % 0x100000000,
        ((l >> n) | ((h & mask) << (32 - n))) % 0x100000000
    }
end

local function u64_shr(x, n)
    local h, l = x[1], x[2]
    if n >= 64 then return {0, 0} end
    if n >= 32 then
        return {0, h >> (n - 32)}
    end
    local mask = (1 << n) - 1
    return {
        h >> n,
        ((l >> n) | ((h & mask) << (32 - n))) % 0x100000000
    }
end

local function u64_xor(a, b)
    return {a[1] ~ b[1], a[2] ~ b[2]}
end

local function u64_and(a, b)
    return {a[1] & b[1], a[2] & b[2]}
end

local function u64_or(a, b)
    return {a[1] | b[1], a[2] | b[2]}
end

local function u64_not(x)
    return {~x[1] % 0x100000000, ~x[2] % 0x100000000}
end

local function u64_from_bytes(bytes, offset)
    local h = (bytes[offset] << 24) | (bytes[offset + 1] << 16) | 
              (bytes[offset + 2] << 8) | bytes[offset + 3]
    local l = (bytes[offset + 4] << 24) | (bytes[offset + 5] << 16) | 
              (bytes[offset + 6] << 8) | bytes[offset + 7]
    return {h, l}
end

local function u64_to_bytes(x)
    local h, l = x[1], x[2]
    return {
        (h >> 24) & 0xFF, (h >> 16) & 0xFF, (h >> 8) & 0xFF, h & 0xFF,
        (l >> 24) & 0xFF, (l >> 16) & 0xFF, (l >> 8) & 0xFF, l & 0xFF
    }
end

local function ch(x, y, z)
    return u64_xor(u64_and(x, y), u64_and(u64_not(x), z))
end

local function maj(x, y, z)
    return u64_xor(u64_xor(u64_and(x, y), u64_and(x, z)), u64_and(y, z))
end

local function sigma0(x)
    return u64_xor(u64_xor(u64_rotr(x, 28), u64_rotr(x, 34)), u64_rotr(x, 39))
end

local function sigma1(x)
    return u64_xor(u64_xor(u64_rotr(x, 14), u64_rotr(x, 18)), u64_rotr(x, 41))
end

local function gamma0(x)
    return u64_xor(u64_xor(u64_rotr(x, 1), u64_rotr(x, 8)), u64_shr(x, 7))
end

local function gamma1(x)
    return u64_xor(u64_xor(u64_rotr(x, 19), u64_rotr(x, 61)), u64_shr(x, 6))
end

local k = {
    {0x428a2f98, 0xd728ae22}, {0x71374491, 0x23ef65cd}, {0xb5c0fbcf, 0xec4d3b2f}, {0xe9b5dba5, 0x8189dbbc},
    {0x3956c25b, 0xf348b538}, {0x59f111f1, 0xb605d019}, {0x923f82a4, 0xaf194f9b}, {0xab1c5ed5, 0xda6d8118},
    {0xd807aa98, 0xa3030242}, {0x12835b01, 0x45706fbe}, {0x243185be, 0x4ee4b28c}, {0x550c7dc3, 0xd5ffb4e2},
    {0x72be5d74, 0xf27b896f}, {0x80deb1fe, 0x3b1696b1}, {0x9bdc06a7, 0x25c71235}, {0xc19bf174, 0xcf692694},
    {0xe49b69c1, 0x9ef14ad2}, {0xefbe4786, 0x384f25e3}, {0x0fc19dc6, 0x8b8cd5b5}, {0x240ca1cc, 0x77ac9c65},
    {0x2de92c6f, 0x592b0275}, {0x4a7484aa, 0x6ea6e483}, {0x5cb0a9dc, 0xbd41fbd4}, {0x76f988da, 0x831153b5},
    {0x983e5152, 0xee66dfab}, {0xa831c66d, 0x2db43210}, {0xb00327c8, 0x98fb213f}, {0xbf597fc7, 0xbeef0ee4},
    {0xc6e00bf3, 0x3da88fc2}, {0xd5a79147, 0x930aa725}, {0x06ca6351, 0xe003826f}, {0x14292967, 0x0a0e6e70},
    {0x27b70a85, 0x46d22ffc}, {0x2e1b2138, 0x5c26c926}, {0x4d2c6dfc, 0x5ac42aed}, {0x53380d13, 0x9d95b3df},
    {0x650a7354, 0x8baf63de}, {0x766a0abb, 0x3c77b2a8}, {0x81c2c92e, 0x47edaee6}, {0x92722c85, 0x1482353b},
    {0xa2bfe8a1, 0x4cf10364}, {0xa81a664b, 0xbc423001}, {0xc24b8b70, 0xd0f89791}, {0xc76c51a3, 0x0654be30},
    {0xd192e819, 0xd6ef5218}, {0xd6990624, 0x5565a910}, {0xf40e3585, 0x5771202a}, {0x106aa070, 0x32bbd1b8},
    {0x19a4c116, 0xb8d2d0c8}, {0x1e376c08, 0x5141ab53}, {0x2748774c, 0xdf8eeb99}, {0x34b0bcb5, 0xe19b48a8},
    {0x391c0cb3, 0xc5c95a63}, {0x4ed8aa4a, 0xe3418acb}, {0x5b9cca4f, 0x7763e373}, {0x682e6ff3, 0xd6b2b8a3},
    {0x748f82ee, 0x5defb2fc}, {0x78a5636f, 0x43172f60}, {0x84c87814, 0xa1f0ab72}, {0x8cc70208, 0x1a6439ec},
    {0x90befffa, 0x23631e28}, {0xa4506ceb, 0xde82bde9}, {0xbef9a3f7, 0xb2c67915}, {0xc67178f2, 0xe372532b},
    {0xca273ece, 0xea26619c}, {0xd186b8c7, 0x21c0c207}, {0xeada7dd6, 0xcde0eb1e}, {0xf57d4f7f, 0xee6ed178},
    {0x06f067aa, 0x72176fba}, {0x0a637dc5, 0xa2c898a6}, {0x113f9804, 0xbef90dae}, {0x1b710b35, 0x131c471b},
    {0x28db77f5, 0x23047d84}, {0x32caab7b, 0x40c72493}, {0x3c9ebe0a, 0x15c9bebc}, {0x431d67c4, 0x9c100d4c},
    {0x4cc5d4be, 0xcb3e42b6}, {0x597f299c, 0xfc657e2a}, {0x5fcb6fab, 0x3ad6faec}, {0x6c44198c, 0x4a475817}
}

local function transform(state, data)
    local w = {}
    
    for i = 1, 16 do
        w[i] = u64_from_bytes(data, (i - 1) * 8 + 1)
    end
    
    for i = 17, 80 do
        w[i] = u64_add(u64_add(u64_add(gamma1(w[i - 2]), w[i - 7]), gamma0(w[i - 15])), w[i - 16])
    end
    
    local a, b, c, d = state[1], state[2], state[3], state[4]
    local e, f, g, h = state[5], state[6], state[7], state[8]
    
    for i = 1, 80 do
        local t1 = u64_add(u64_add(u64_add(u64_add(h, sigma1(e)), ch(e, f, g)), k[i]), w[i])
        local t2 = u64_add(sigma0(a), maj(a, b, c))
        h = g
        g = f
        f = e
        e = u64_add(d, t1)
        d = c
        c = b
        b = a
        a = u64_add(t1, t2)
    end
    
    state[1] = u64_add(state[1], a)
    state[2] = u64_add(state[2], b)
    state[3] = u64_add(state[3], c)
    state[4] = u64_add(state[4], d)
    state[5] = u64_add(state[5], e)
    state[6] = u64_add(state[6], f)
    state[7] = u64_add(state[7], g)
    state[8] = u64_add(state[8], h)
end

function sha.sha384(input)
    local state = {
        {0xcbbb9d5d, 0xc1059ed8},
        {0x629a292a, 0x367cd507},
        {0x9159015a, 0x3070dd17},
        {0x152fecd8, 0xf70e5939},
        {0x67332667, 0xffc00b31},
        {0x8eb44a87, 0x68581511},
        {0xdb0c2e0d, 0x64f98fa7},
        {0x47b5481d, 0xbefa4fa4}
    }
    
    local len = #input
    local data = {}
    for i = 1, len do
        data[i] = string.byte(input, i)
    end
    
    data[len + 1] = 0x80
    
    while (#data % 128) ~= 112 do
        data[#data + 1] = 0
    end
    
    local bits = len * 8
    for i = 8, 1, -1 do
        data[#data + 1] = (bits >> ((i - 1) * 8)) & 0xFF
    end
    for i = 1, 8 do
        data[#data + 1] = 0
    end
    
    for i = 1, #data, 128 do
        local block = {}
        for j = 1, 128 do
            block[j] = data[i + j - 1] or 0
        end
        transform(state, block)
    end
    
    local result = ""
    for i = 1, 6 do
        local bytes = u64_to_bytes(state[i])
        for j = 1, 8 do
            result = result .. string.format("%02x", bytes[j])
        end
    end
    
    return result
end

return sha

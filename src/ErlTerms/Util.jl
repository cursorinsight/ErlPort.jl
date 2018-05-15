# 1-byte unsigned integer -> UInt64
function size1unpack(bytes::Array{UInt8,1})
    size1unpack(bytes[1])
end

function size1unpack(byte::UInt8)
    UInt64(byte)
end

# 2-bytes unsigned integer in big endian format -> UInt64
function size2unpack(bytes::Array{UInt8,1})
    size = reinterpret(UInt16, reverse(bytes[max(1, length(bytes) - 2):length(bytes)]))
    if length(size) > 0
        UInt64(size[1])
    else
        UInt64(0)
    end
end

# 4-bytes unsigned integer in big endian format -> UInt64
function size4unpack(bytes::Array{UInt8,1})
    size = reinterpret(UInt32, reverse(bytes[max(1, length(bytes) - 4):length(bytes)]))
    if length(size) > 0
        UInt64(size[1])
    else
        UInt64(0)
    end
end

function int1unpack(bytes::Array{UInt8,1})
    int1unpack(bytes[1])
end

function int1unpack(byte::UInt8)
    Int(byte)
end

function int4unpack(bytes)
    Int(reinterpret(Int32, reverse(bytes[max(1, length(bytes) - 4):length(bytes)]))[1])
end

function floatunpack(bytes)
    reinterpret(Float64, reverse(bytes[max(1, length(bytes) - 8):length(bytes)]))[1]
end

function charintpack(value::Integer, size::Int)
    bytes = zeros(UInt8, size)
    for i in 1:size
        bytes[i] = UInt8(value & 0xff)
        value = value >>> 8
    end
    reverse(bytes)
end

function charintpack(value::Integer)
    bytes = []
    while value != 0
        bytes = vcat(bytes, UInt8(value & 0xff))
        value = value >>> 8
    end
    bytes
end

function charint4pack(integer::Integer)
    charintpack(integer, 4)
end

function charint2pack(integer::Integer)
    charintpack(integer, 2)
end

function charsignedint4pack(integer::Integer)
    charintpack(integer, 4)
end

function lencheck(bytes::Array{UInt8,1}, limit::Int)
    len = UInt64(length(bytes))
    lencheck(len, len < limit, bytes)
end

function lencheck(len::UInt64, limit::UInt64, bytes::Array{UInt8,1})
    lencheck(limit, len < limit, bytes)
end

function lencheck(len::UInt64, pred::Bool, bytes::Array{UInt8,1})
    if pred
        throw(IncompleteData(bytes))
    end
    len
end

function compressterm(encodedterm, compression::Bool)
    compressterm(encodedterm, 6)
end

function compressterm(encodedterm, compression::Int)
    throw(NotImplemented())
end

function decompressterm(bytes::Array{UInt8,1})
    throw(NotImplemented())
end

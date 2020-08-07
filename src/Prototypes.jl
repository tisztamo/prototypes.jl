module Prototypes

export Prototyped, Object

abstract type Prototyped end

struct Object <: Prototyped
end

Base.getproperty(o::Object, name::Symbol) = getfield(o, name)

Base.getproperty(obj::Prototyped, name::Symbol) = begin
    return get(getfield(obj, :values), name) do
        Base.getproperty(prototypeof(obj), name)
    end
end

Base.setproperty!(obj::Prototyped, name::Symbol, value) = begin
    getfield(obj, :values)[name] = value
    return value
end

function prototypeof(obj::Prototyped)
    return getfield(obj, :__proto)
end

end # module

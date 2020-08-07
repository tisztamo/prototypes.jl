using Prototypes
using Test, BenchmarkTools

struct A <: Prototyped
    values::Dict{Symbol, Any}
    __proto
    A(prototype=Object()) = new(Dict(), prototype)
end

struct B{TProto} <: Prototyped
    values::Dict{Symbol, Any}
    __proto::TProto
    B(prototype=Object()) = new{typeof(prototype)}(Dict(), prototype)
end

@testset "basics" begin
    a1 = A()
    a1.vala = 42
    @test_throws ErrorException a1.valx
    @test a1.vala === 42
    a2 = A(a1)
    a2.vala = 1
    @test a2.vala === 1
    b1 = B(a1)
    b1.valb = "b1"
    b1.valb1 = "b11"
    b2 = B(b1)
    b2.valb = "b2"
    @test b1.valb === "b1"
    @test b1.valb1 === "b11"
    @test b1.vala === 42
    @test_throws ErrorException b1.valx
    @test b2.valb === "b2"
    @test b2.valb1 === "b11"
    @test b2.vala === 42
    @test_throws ErrorException b2.valx

    a1.valx = 20
    @test b2.valx === 20
    @test b1.valx === 20
    @test a2.valx === 20
    @test a1.valx === 20
    b1.valx = 30
    @test b2.valx === 30
    @test b1.valx === 30
    @test a2.valx === 20
    @test a1.valx === 20
end

@testset "benchmarks" begin
    a1 = A()
    a1.vala = 42
    b1 = B(a1)
    b2 = B(b1)
    b3 = B(b2)
    b4 = B(b3)

    @btime $a1.vala
    @btime $b1.vala
    @btime $b2.vala
    @btime $b3.vala
    @btime $b4.vala

    a1.a1 = 1
    b1.b1 = 1
    b2.b2 = 1
    b3.b3 = 1
    b4.b4 = 1
    @test (@btime $a1.vala) === 42
    @btime $b1.vala
    @btime $b2.vala
    @btime $b3.vala
    @btime $b4.vala
end
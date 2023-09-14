<?php

class testClass
{
    public function __construct(readonly private string $var)
    {
        $test = $this->var;
        $this->var = $test;

    }

    public function test()
    {
        $test = "a";
        return $test;
    }

    public function test_z()
    {
        $this->test();
    }


    public function a(){
        echo $this->test();

    }

    public function b(){
        $test = "a";
    }

    public function testFunction(string $test){
        $test = "ok";
        return $test;
    }

    public function ttestAaign(AddressInfo $test){
    }

}

class newModel {
    public function __construct(private readonly testClass $testClass){
    }
}

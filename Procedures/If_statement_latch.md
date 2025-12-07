When designing circuits, you must think first in terms of circuits:

_I want this logic gate
I want a combinational blob of logic that has these inputs and produces these outputs
I want a combinational blob of logic followed by a set of flip-flops_

Syntactically-correct code does not necessarily result in a reasonable circuit (combinational logic + flip-flops). The usual reason is: "What happens in the cases other than those you specified?". Verilog's answer is: Keep the outputs unchanged.

This behaviour of "keep outputs unchanged" means the current state needs to be remembered, and thus produces a latch. Combinational logic (e.g., logic gates) cannot remember any state. 

The following code contains incorrect behaviour that creates a latch. Fix the bugs so that you will shut off the computer only if it's really overheated, and stop driving if you've arrived at your destination or you need to refuel.

Before Correction

```verilog
module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  ); //

    always @(*) begin
        if (cpu_overheated)
           shut_off_computer = 1;
    end

    always @(*) begin
        if (~arrived)
           keep_driving = ~gas_tank_empty;
    end

endmodule
```

After Correction

```verilog
module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  ); //

    always @(*) begin
        if (cpu_overheated)
           shut_off_computer = 1;
        else
           shut_off_computer = 0;
    end

    always @(*) begin
        if (arrived)
           keep_driving = 0;
        else
           keep_driving = ~gas_tank_empty;
    end

endmodule
```

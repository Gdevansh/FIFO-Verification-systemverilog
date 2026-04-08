class fifo_driver;
    virtual fifo_if vif;

    function new(virtual fifo_if vif);
        this.vif = vif;
    endfunction

    task write(input [7:0] data);
        @(posedge vif.clk);
        vif.wr_en = 1;
        vif.din = data;
        vif.rd_en = 0;
    endtask

    task read();
        @(posedge vif.clk);
        vif.rd_en = 1;
        vif.wr_en = 0;
    endtask

endclass

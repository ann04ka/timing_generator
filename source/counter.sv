module counter #(
    parameter int N = 28
) (
    input logic clk,
    input logic reset,
    input logic enable,
    input logic [(N-1):0] modul,
    output logic c_out,
    output logic [(N-1):0] q_out
);
  // РѕР±СЉСЏРІР»РµРЅРёРµ РІРЅСѓС‚СЂРµРЅРЅРёС… СЃРёРіРЅР°Р»РѕРІ
  logic [(N-1):0] q_in;
  // РїСЂРѕС†РµСЃСЃ СЃС‡РµС‚С‡РёРєР°
  always_ff @(posedge clk, posedge reset)
    if (reset) begin
      q_in <= 0;
    end else
    if (enable) begin
    end else if (q_in < modul - 1) begin
      q_in <= q_in + 1;
    end else begin
      q_in <= 0;
    end
  // РїСЂРѕС†РµСЃСЃ РґР»СЏ С„РѕСЂРјРёСЂРѕРІР°РЅРёСЏ СЃРёРіРЅР°Р»Р° РїРµСЂРµРїРѕР»РЅРµРЅРёСЏ
  always_ff @(posedge clk, posedge reset)
    if (reset) begin
      c_out <= 0;
    end else
    if (enable) begin
    end else if (q_in == modul - 2) begin
      c_out <= 1;
    end else begin
      c_out <= 0;
    end
  assign q_out = q_in;


endmodule

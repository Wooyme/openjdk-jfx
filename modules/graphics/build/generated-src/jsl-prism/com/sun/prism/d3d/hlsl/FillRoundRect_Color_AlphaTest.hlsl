float2 oinvarcradii : register(c0);
float mask(float2 tco, float2 oflatdim) {
float2 absecctco = max(abs(tco) - oflatdim, 0.001) * oinvarcradii;
float ecclensq = dot(absecctco, absecctco);
float pix = dot(absecctco / ecclensq, oinvarcradii);
return clamp(0.5 + (1.0 + 0.25 * pix * pix - ecclensq) / (2.0 * pix), 0.0, 1.0);
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = mask(pos0, pos1) * jsl_vertexColor;
if (color.a == 0.0)discard;}

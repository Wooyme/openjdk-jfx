sampler2D baseImg : register(s0);
float threshold : register(c0);
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
float3 luminanceVector = float3(0.2125, 0.7154, 0.0721);
float4 val = tex2D(baseImg, pos0);
float luminance = dot(luminanceVector, val.rgb);
luminance = max(0.0, luminance - val.a * threshold);
color = val * sign(luminance);
}

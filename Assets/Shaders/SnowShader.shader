Shader "ACG/SnowShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Snow("Snow Level", Range(-1, 1)) = 0.5
        _SnowColor("Snow Color", Color) = (1,1,1,1)
        _SnowDirection("Snow Direction", Vector) = (0, 1, 0)
        _SnowDepth("Snow Depth", Range(0, 1)) = 0

    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert vertex:vert

            struct Input{
                float2 uv_MainTex;
                float3 worldNormal;
                INTERNAL_DATA
            };

            float _Snow;
            float4 _SnowColor;
            float3 _SnowDirection;
            float _SnowDepth;
            sampler2D _MainTex;

            void vert(inout appdata_full v){
                float3 snowDir = normalize(_SnowDirection.xyz);
                if(dot(snowDir, v.normal)>=_Snow){
                    v.vertex.xyz += v.normal * _SnowDepth;
                }
            }

            void surf(Input IN, inout SurfaceOutput o){
                float4 colorT = tex2D(_MainTex, IN.uv_MainTex);
                float3 wNormal = WorldNormalVector(IN, o.Normal.xyz);

                if(dot(wNormal, _SnowDirection.xyz)>=_Snow){
                   o.Albedo = _SnowColor.rbg;
                } else {
                    o.Albedo = colorT.rgb;
                }
            
            }

        ENDCG
    }
    FallBack "Diffuse"
}

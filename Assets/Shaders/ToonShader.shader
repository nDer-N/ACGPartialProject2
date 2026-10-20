Shader "ACG/ToonShader"{
    Properties{
        _Color("Color", Color) = (1,1,1,1)
        _RampTex("RAMP", 2D) = "white"{}
        _MainTex("Texture", 2D) = "white"{}

    }

    SubShader {
        CGPROGRAM
            #pragma surface surf ToonShade

            float4 _Color;
            sampler2D _RampTex;
            sampler2D _MainTex;

            half4 LightingToonShade(SurfaceOutput s, half3 lightDir, half atten){
                float dotProduct = dot(s.Normal, lightDir) ;
                //half dotProuct = max(0, dot(s.Normal, lightDir));
                float h = dotProduct * 0.5 + 0.5;
                float2 hw = h;
                float3 rampColor = tex2D(_RampTex, hw).rgb;

                float4 c;

                c.rgb = s.Albedo * _LightColor0.rgb * (rampColor);
                c.a = s.Alpha;

                return c;
            }

            struct Input{
                float2 uv_MainTex;
            };

            void surf(Input IN, inout SurfaceOutput o){
                o.Albedo = tex2D(_MainTex, IN.uv_MainTex );

            }

        ENDCG
    }

    Fallback "Diffuse"
}
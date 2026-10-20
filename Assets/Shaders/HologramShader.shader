Shader "ACG/HologramShader"{
    Properties {
        _rimColor("Color", Color) = (0, 0, 0, 0)
        _rimColorIntensity("Intensity", Range(0, 5)) = 1
    }

    SubShader {

        Tags{
            "Queue"="Transparent"
        }

        Pass{
            ZWrite On
            ColorMask 0

        }

        CGPROGRAM
            #pragma surface surf Lambert alpha:fade

            fixed4 _rimColor;
            fixed _rimColorIntensity;
            

            struct Input{
                float2 uv_mainTex;
                float3 viewDir;
            };

            void surf(Input IN, inout SurfaceOutput o){
                half rim = dot(normalize(IN.viewDir), o.Normal);
                half rimInv;
                rimInv=1-rim;
                
                o.Emission = pow(rimInv, _rimColorIntensity)*_rimColor.rgb;

                o.Alpha = pow(rimInv, _rimColorIntensity);
               

                //o.Emission = (rim)*_rimColor.rgb;
            }


        ENDCG
    }
    Fallback "Diffuse"
}
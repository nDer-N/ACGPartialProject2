Shader "ACG/ExtrudeShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Extrude("Extrude Intensity", Range(-1, 1)) = 0.01 
        
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert vertex:vert

            struct Input{
                float2 uv_MainTex;

            };

            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            sampler2D _MainTex;
            float _Extrude;
            float time = 0;

            void vert(inout appdata v){
                time = sin(_Time.y)+1;

                v.vertex.xyz += v.normal * time*_Extrude;
            }

            void surf(Input IN, inout SurfaceOutput o){
                o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
            }



        ENDCG
    }
    FallBack "Diffuse"
}

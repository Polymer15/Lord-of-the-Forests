Shader "Unlit/TileTerrain"
{
    Properties
	{
		// Texture configuration
		_DiffuseTex("Diffuse", 2D) = "white" {}
		_MapWidth("Map Width", int) = 0
		_WorldWidth("World Width", int) = 0
		

		// Global illumination modifiers
		_GlobalLumosity("Global Lumosity", Range(0, 1)) = 1
		_GlobalHue("Global Hue", Color) = (1, 1, 1, 1)

    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 200
		ZWrite On
	
		Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
			#pragma target 4.0
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _DiffuseTex;
            float4 _DiffuseTex_ST;

			uint _ID;
			uint _MapWidth;
			uint _WorldWidth;

			half _GlobalLumosity;
			float4 _GlobalHue;

			float _allIDs[256];

            v2f vert (appdata v) {
                v2f o;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _DiffuseTex);

                return o;
            }

			fixed4 frag (v2f i) : SV_Target {
				float mapSizeModif = 1.0f / _MapWidth;
				float worldSizeModif = 1.0f / _WorldWidth;

				uint index = (int)	(floor(i.uv.x * _WorldWidth) +
									(floor(i.uv.y * _WorldWidth) * _WorldWidth));

				i.uv.x = i.uv.x % worldSizeModif;
				i.uv.y = i.uv.y % worldSizeModif;

				uint id = (uint) _allIDs[index];

				i.uv.x += mapSizeModif * (id % _MapWidth);
				i.uv.y += mapSizeModif * floor (((float)id) / _MapWidth);
				
				fixed4 col = tex2D (_DiffuseTex, i.uv);
				col *= _GlobalLumosity;
				col *= _GlobalHue;

				return col;
			}

            ENDCG
        }
    }
}

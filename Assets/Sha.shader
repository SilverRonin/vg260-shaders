Shader "Custom/Spec"{

	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_SpecColor ("SpecColor", Color) = (1,1,1,1)
		_Shininess ("Shininess", Float) = 10

	}
		SubShader {
			Pass {
			Tags { "LightMode" = "ForwardBase" }
			CGPROGRAM
	
			//pragma

			#pragma vertex vert
			#pragma fragment frag

			//user inputs
			uniform float4 _Color;
			uniform float4 _SpecColor;
			uniform float _Shininess;

			//unity inputs
			uniform float4 _LightColor0;


			//appdata struct
			struct appdata {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};






			//v2f struct
			struct v2f{
			float4 vertex : SV_POSITION;
			float4 color : COLOR;

			};


			////vertex function
		v2f vert (appdata v) {
			v2f o;
				





				
				// Things that are missing:
				// Attenuation to control diffuse strength
				// Shininess power
				// ambient lighting color
				// _Color input
				// _SpecColor input
				
				// vectors
				// normal direction
				float3 normalDirection = normalize( mul( float4( v.normal, 0.0), _World2Object ).xyz);
				
				// view direction = camera position - vertex position = distance between camera and vertex
				float3 viewDirection = normalize( float3( float4(_WorldSpaceCameraPos.xyz, 1.0) - mul(_Object2World, v.vertex).xyz ) );
				
				// light direction
				float4 lightDirection = normalize(_WorldSpaceLightPos0);
				
				// diffuse reflection - lambert
				float3 diffuseReflection = _LightColor0.xyz * max( 0.0, dot(normalDirection, lightDirection ) );
				
				// specular reflection
				float3 specularReflection = max(0.0, dot(normalDirection, lightDirection) ) * max (0.0, dot ( reflect ( -lightDirection, normalDirection), viewDirection ) );
				
				float3 lightFinal = diffuseReflection + specularReflection;
				
				o.color = float4(lightFinal, 1);
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}
			
			// fragment function
			float4 frag (v2f i) : COLOR {
				return i.color;
			}
			
			ENDCG
		}



}






}
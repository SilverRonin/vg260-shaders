Shader "Custom/Flat"{
	Properties{
	_Color ("Color", Color) = (1,1,1,1)

	
	}
	SubShader{
		Pass{
		Tags { "LightMode" = "ForwardBase"}
		CGPROGRAM

		//TAGS

						// vertex=type, vert = function name
		#pragma vertex vert
		#pragma fragment frag

		uniform float4 _Color;

		uniform float4 _LightColor0;


									//input
		struct appdata{
			float4 vertex: POSITION;
			float3 normal : NORMAL;
			
		
		};
										//output
		struct v2f {
		
			float4 vertex: SV_POSITION;
			float4 color : COLOR;
		
		};




		v2f vert (appdata v){
			v2f o;
			
												//normalDirection =normal of the vertex/pixel
			float3 normalDirection =  mul(float4 (v.normal, 0.0), _World2Object).xyz;

													//lightDirection =light direction
			float3 lightDirection = normalize( _WorldSpaceLightPos0.xyz);

														//diffuseReflection = _LightColor0 * dot(normalDirection, lightDirection)
			float3 diffuseReflection = _Color *_LightColor0.xyz * dot(normalDirection, lightDirection.xyz);

										//take ther dot [product of the light direction and pixel-normal]

											//built in variables
			
												//normalize ()
												//_World2Object
												//_WorldSpaceLightPos0
												// _LightColor0

										// built-in functions
										////dot(lightDirection, normal);
										//float3 diffuseReflection = atten * LightColor0.xyz * _Color.rgb *max 0.0, dot(normalDirection)

										///return the diffuseReflection;
			o.color = float4(diffuseReflection, 1);
												//MUST BE IN EVERY SHADER!!!!////
			o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);

			return  o;
		
		}

												//fragment/pixel program/functions
		float4 frag (v2f i) : COLOR {
		return i.color;
		
		}

		ENDCG
		}

	}
	//Fallback "diffuse"
}
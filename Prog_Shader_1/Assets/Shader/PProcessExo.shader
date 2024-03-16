// Made with Amplify Shader Editor v1.9.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PPOutline"
{
	Properties
	{
		_Float1("Float 1", Range( 0 , 20)) = 3.085306
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		Cull Off
		ZWrite Off
		ZTest Always
		
		Pass
		{
			CGPROGRAM

			

			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_FRAG_SCREEN_POSITION_NORMALIZED

		
			struct ASEAttributesDefault
			{
				float3 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				
			};

			struct ASEVaryingsDefault
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
				float2 texcoordStereo : TEXCOORD1;
			#if STEREO_INSTANCING_ENABLED
				uint stereoTargetEyeIndex : SV_RenderTargetArrayIndex;
			#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform sampler2D _TextureSample0;
			uniform float4 _TextureSample0_ST;
			UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
			uniform float4 _CameraDepthTexture_TexelSize;
			uniform float _Float1;


			
			float2 TransformTriangleVertexToUV (float2 vertex)
			{
				float2 uv = (vertex + 1.0) * 0.5;
				return uv;
			}

			ASEVaryingsDefault Vert( ASEAttributesDefault v  )
			{
				ASEVaryingsDefault o;
				o.vertex = float4(v.vertex.xy, 0.0, 1.0);
				o.texcoord = TransformTriangleVertexToUV (v.vertex.xy);
#if UNITY_UV_STARTS_AT_TOP
				o.texcoord = o.texcoord * float2(1.0, -1.0) + float2(0.0, 1.0);
#endif
				o.texcoordStereo = TransformStereoScreenSpaceTex (o.texcoord, 1.0);

				v.texcoord = o.texcoordStereo;
				float4 ase_ppsScreenPosVertexNorm = float4(o.texcoordStereo,0,1);

				

				return o;
			}

			float4 Frag (ASEVaryingsDefault i  ) : SV_Target
			{
				float4 ase_ppsScreenPosFragNorm = float4(i.texcoordStereo,0,1);

				float2 uv_TextureSample0 = i.texcoord.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
				float eyeDepth20 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_ppsScreenPosFragNorm.xy ));
				float temp_output_15_0 = ( _ProjectionParams.z * eyeDepth20 );
				float temp_output_37_0 = ( _MainTex_TexelSize.x * _Float1 );
				float4 appendResult27 = (float4(( ase_ppsScreenPosFragNorm.x - temp_output_37_0 ) , ase_ppsScreenPosFragNorm.y , ase_ppsScreenPosFragNorm.z , ase_ppsScreenPosFragNorm.w));
				float eyeDepth21 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, appendResult27.xy ));
				float4 appendResult28 = (float4(( ase_ppsScreenPosFragNorm.x + temp_output_37_0 ) , ase_ppsScreenPosFragNorm.y , ase_ppsScreenPosFragNorm.z , ase_ppsScreenPosFragNorm.w));
				float eyeDepth22 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, appendResult28.xy ));
				float temp_output_38_0 = ( _MainTex_TexelSize.y * _Float1 );
				float4 appendResult29 = (float4(ase_ppsScreenPosFragNorm.x , ( ase_ppsScreenPosFragNorm.y - temp_output_38_0 ) , ase_ppsScreenPosFragNorm.z , ase_ppsScreenPosFragNorm.w));
				float eyeDepth23 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, appendResult29.xy ));
				float4 appendResult30 = (float4(ase_ppsScreenPosFragNorm.x , ( ase_ppsScreenPosFragNorm.y + temp_output_38_0 ) , ase_ppsScreenPosFragNorm.z , ase_ppsScreenPosFragNorm.w));
				float eyeDepth24 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, appendResult30.xy ));
				float lerpResult50 = lerp( ( ( ( ( temp_output_15_0 - ( _ProjectionParams.z * eyeDepth21 ) ) * 33.94 ) + ( ( temp_output_15_0 - ( _ProjectionParams.z * eyeDepth22 ) ) * 33.94 ) ) + ( ( ( temp_output_15_0 - ( _ProjectionParams.z * eyeDepth23 ) ) * 33.94 ) + ( ( temp_output_15_0 - ( _ProjectionParams.z * eyeDepth24 ) ) * 33.94 ) ) ) , 0.0 , 3.01);
				float4 color52 = IsGammaSpace() ? float4(0.6415094,0.1845852,0.1845852,0) : float4(0.3691636,0.02850351,0.02850351,0);
				

				float4 color = ( tex2D( _TextureSample0, uv_TextureSample0 ) + ( lerpResult50 * color52 ) );
				
				return color;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19200
Node;AmplifyShaderEditor.ScreenPosInputsNode;36;-2273.793,-404.0948;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-353.7249,-119.0949;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-348.7249,-8.094957;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-352.7249,103.9051;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-139.7249,-76.09496;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-135.7249,139.9051;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-343.7249,226.9051;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-607.0552,75.64771;Inherit;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;0;False;0;False;33.94;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;12;-678.5307,-40.68517;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;13;-698.5307,151.3149;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;14;-698.5307,263.3149;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1012.587,-245.6055;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1004.988,-135.4058;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-1001.188,-15.70572;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-993.5886,111.5943;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-981.2438,267.695;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;24;-1392.291,277.2562;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;23;-1417.89,117.256;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;22;-1411.491,-28.34401;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;21;-1421.091,-133.9441;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-1743.346,-38.08304;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;30;-1735.344,347.5174;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;27;-1740.146,-196.4828;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ProjectionParams;26;-1403.826,-434.3805;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;20;-1426.512,-248.2983;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-2454.205,49.28102;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-2452.874,179.1856;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-2094.762,366.9196;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-2851.903,3.302673;Float;False;Property;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;3.085306;0;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;34;-2170.397,-239.2005;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;33;-2099.064,254.196;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;-1739.993,127.8655;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;11;-677.5307,-152.4366;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;30.02676,-6.094957;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;49;-2812.663,122.8389;Inherit;True;0;0;_MainTex_TexelSize;Pass;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;50;321.6107,-1.37737;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;72.91859,154.4968;Inherit;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;0;False;0;False;3.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;481.765,143.7458;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;52;136.7143,270.8701;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;0.6415094,0.1845852,0.1845852,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;54;243.3515,-233.558;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;8aba6bb20faf8824d9d81946542f1ce1;8aba6bb20faf8824d9d81946542f1ce1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;55;702.4789,13.0347;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-2146.608,-2.295876;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;931.9216,6.293676;Float;False;True;-1;2;ASEMaterialInspector;0;8;PPOutline;32139be9c1eb75640a847f011acf3bcf;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;True;7;False;;False;False;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;4;0;11;0
WireConnection;4;1;10;0
WireConnection;5;0;12;0
WireConnection;5;1;10;0
WireConnection;6;0;13;0
WireConnection;6;1;10;0
WireConnection;3;0;4;0
WireConnection;3;1;5;0
WireConnection;8;0;6;0
WireConnection;8;1;7;0
WireConnection;7;0;14;0
WireConnection;7;1;10;0
WireConnection;12;0;15;0
WireConnection;12;1;17;0
WireConnection;13;0;15;0
WireConnection;13;1;18;0
WireConnection;14;0;15;0
WireConnection;14;1;19;0
WireConnection;15;0;26;3
WireConnection;15;1;20;0
WireConnection;16;0;26;3
WireConnection;16;1;21;0
WireConnection;17;0;26;3
WireConnection;17;1;22;0
WireConnection;18;0;26;3
WireConnection;18;1;23;0
WireConnection;19;0;26;3
WireConnection;19;1;24;0
WireConnection;24;0;30;0
WireConnection;23;0;29;0
WireConnection;22;0;28;0
WireConnection;21;0;27;0
WireConnection;28;0;35;0
WireConnection;28;1;36;2
WireConnection;28;2;36;3
WireConnection;28;3;36;4
WireConnection;30;0;36;1
WireConnection;30;1;32;0
WireConnection;30;2;36;3
WireConnection;30;3;36;4
WireConnection;27;0;34;0
WireConnection;27;1;36;2
WireConnection;27;2;36;3
WireConnection;27;3;36;4
WireConnection;20;0;36;0
WireConnection;37;0;49;1
WireConnection;37;1;39;0
WireConnection;38;0;49;2
WireConnection;38;1;39;0
WireConnection;32;0;36;2
WireConnection;32;1;38;0
WireConnection;34;0;36;1
WireConnection;34;1;37;0
WireConnection;33;0;36;2
WireConnection;33;1;38;0
WireConnection;29;0;36;1
WireConnection;29;1;33;0
WireConnection;29;2;36;3
WireConnection;29;3;36;4
WireConnection;11;0;15;0
WireConnection;11;1;16;0
WireConnection;9;0;3;0
WireConnection;9;1;8;0
WireConnection;50;0;9;0
WireConnection;50;2;51;0
WireConnection;53;0;50;0
WireConnection;53;1;52;0
WireConnection;55;0;54;0
WireConnection;55;1;53;0
WireConnection;35;0;36;1
WireConnection;35;1;37;0
WireConnection;0;0;55;0
ASEEND*/
//CHKSM=A74DF94E7D3CD7DF562CDBC134923A91C9067E8D
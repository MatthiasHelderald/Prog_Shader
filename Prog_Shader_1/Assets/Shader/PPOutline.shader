// Made with Amplify Shader Editor v1.9.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PPOutline"
{
	Properties
	{
		_OutlineTickness("OutlineTickness", Range( 0 , 3)) = 3
		_OutlineColor("OutlineColor", Color) = (1,1,1,0)
		_OutlineIntensity("OutlineIntensity", Range( 0 , 1)) = 0
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
			
			uniform float4 _OutlineColor;
			UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
			uniform float4 _CameraDepthTexture_TexelSize;
			uniform float _OutlineTickness;
			uniform float _OutlineIntensity;


			
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

				float2 uv_MainTex = i.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 tex2DNode66 = tex2D( _MainTex, uv_MainTex );
				float eyeDepth20 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_ppsScreenPosFragNorm.xy ));
				float temp_output_15_0 = ( _ProjectionParams.z * eyeDepth20 );
				float temp_output_37_0 = ( _MainTex_TexelSize.x * _OutlineTickness );
				float4 appendResult27 = (float4(( ase_ppsScreenPosFragNorm.x - temp_output_37_0 ) , ase_ppsScreenPosFragNorm.y , ase_ppsScreenPosFragNorm.z , ase_ppsScreenPosFragNorm.w));
				float eyeDepth21 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, appendResult27.xy ));
				float4 appendResult28 = (float4(( ase_ppsScreenPosFragNorm.x + temp_output_37_0 ) , ase_ppsScreenPosFragNorm.y , ase_ppsScreenPosFragNorm.z , ase_ppsScreenPosFragNorm.w));
				float eyeDepth22 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, appendResult28.xy ));
				float temp_output_38_0 = ( _MainTex_TexelSize.y * _OutlineTickness );
				float4 appendResult29 = (float4(ase_ppsScreenPosFragNorm.x , ( ase_ppsScreenPosFragNorm.y - temp_output_38_0 ) , ase_ppsScreenPosFragNorm.z , ase_ppsScreenPosFragNorm.w));
				float eyeDepth23 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, appendResult29.xy ));
				float4 appendResult30 = (float4(ase_ppsScreenPosFragNorm.x , ( ase_ppsScreenPosFragNorm.y + temp_output_38_0 ) , ase_ppsScreenPosFragNorm.z , ase_ppsScreenPosFragNorm.w));
				float eyeDepth24 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, appendResult30.xy ));
				float4 lerpResult70 = lerp( tex2DNode66 , ( _OutlineColor * ( ( ( temp_output_15_0 - ( _ProjectionParams.z * eyeDepth21 ) ) + ( temp_output_15_0 - ( _ProjectionParams.z * eyeDepth22 ) ) + ( temp_output_15_0 - ( _ProjectionParams.z * eyeDepth23 ) ) + ( temp_output_15_0 - ( _ProjectionParams.z * eyeDepth24 ) ) ) * _OutlineIntensity ) ) , _OutlineIntensity);
				

				float4 color = max( tex2DNode66 , lerpResult70 );
				
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
Node;AmplifyShaderEditor.DynamicAppendNode;30;-1719.284,159.3788;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;-1718.933,-0.2730331;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-1715.286,-163.2216;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;33;-2050.319,21.44078;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-2020.629,167.5685;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-2019.028,-160.2266;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;34;-2050.834,-322.3062;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-2305.013,-193.0062;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-2303.685,5.240763;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;21;-1403.715,-130.0828;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;22;-1405.699,-28.34401;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;23;-1406.306,61.26696;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;24;-1405.806,163.3476;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;20;-1401.413,-215.4772;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1012.587,-214.7151;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1014.641,-108.3766;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-1016.633,-7.983094;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-1016.757,100.0104;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-1017.926,209.7753;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;11;-665.9467,-150.506;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;12;-669.2969,-24.82043;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;14;-672.776,207.9524;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;13;-669.6951,105.7367;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-434.4193,46.73629;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ProjectionParams;26;-1401.895,-380.3219;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;49;-2619.816,-88.27715;Inherit;True;0;0;_MainTex_TexelSize;Pass;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;27;-1713.086,-316.6213;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;66;96.49393,-371.5679;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;0,0,0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;65;-247.6253,-379.6274;Inherit;True;0;0;_MainTex;Pass;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenPosInputsNode;36;-2324.453,-398.7146;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;39;-2627.943,-192.4135;Float;False;Property;_OutlineTickness;OutlineTickness;0;0;Create;True;0;0;0;False;0;False;3;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-439.4606,214.6029;Inherit;False;Property;_OutlineIntensity;OutlineIntensity;2;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;217.0953,33.50948;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;52;-56.19315,-121.904;Inherit;False;Property;_OutlineColor;OutlineColor;1;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.9150943,0.9150943,0.9150943,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-161.3566,52.93983;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;850.5915,86.30599;Float;False;True;-1;2;ASEMaterialInspector;0;8;PPOutline;32139be9c1eb75640a847f011acf3bcf;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;True;7;False;;False;False;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;0;;0;0;Standard;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.LerpOp;70;457.1003,81.50948;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;123;630.7818,2.968018;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StickyNoteNode;126;655.3299,-187.3699;Inherit;False;221;138;Final Mix;;1,1,1,1;Ajout d'une node max afin d'éviter qu'il y ait un gradient sur les autres pixels quand on met de la couleur entre les valeurs 0-1;0;0
Node;AmplifyShaderEditor.StickyNoteNode;127;449.1407,223.5513;Inherit;False;221;138;Mix;;1,1,1,1;On combine l'outline colorée avec la couleur d'origine du render pipeline grâce à une node Lerp;0;0
Node;AmplifyShaderEditor.StickyNoteNode;128;-1400.897,298.539;Inherit;False;221;138;Comparaison;;1,1,1,1;On Compare les valeur de depth des pixels entre elles;0;0
Node;AmplifyShaderEditor.StickyNoteNode;129;-437.3306,314.7929;Inherit;False;221;138;Float;;1,1,1,1;Ajout d'un float pour controller l'intensité de l'outline le multiply donne un meilleur controle que le add dans ce cas là en raison des valeurs des pixels;0;0
Node;AmplifyShaderEditor.StickyNoteNode;131;-2626.291,-382.0355;Inherit;False;221;138;Float;;1,1,1,1;Float pour Controller la thickness de l'outline;0;0
WireConnection;30;0;36;1
WireConnection;30;1;32;0
WireConnection;30;2;36;3
WireConnection;30;3;36;4
WireConnection;29;0;36;1
WireConnection;29;1;33;0
WireConnection;29;2;36;3
WireConnection;29;3;36;4
WireConnection;28;0;35;0
WireConnection;28;1;36;2
WireConnection;28;2;36;3
WireConnection;28;3;36;4
WireConnection;33;0;36;2
WireConnection;33;1;38;0
WireConnection;32;0;36;2
WireConnection;32;1;38;0
WireConnection;35;0;36;1
WireConnection;35;1;37;0
WireConnection;34;0;36;1
WireConnection;34;1;37;0
WireConnection;37;0;49;1
WireConnection;37;1;39;0
WireConnection;38;0;49;2
WireConnection;38;1;39;0
WireConnection;21;0;27;0
WireConnection;22;0;28;0
WireConnection;23;0;29;0
WireConnection;24;0;30;0
WireConnection;20;0;36;0
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
WireConnection;11;0;15;0
WireConnection;11;1;16;0
WireConnection;12;0;15;0
WireConnection;12;1;17;0
WireConnection;14;0;15;0
WireConnection;14;1;19;0
WireConnection;13;0;15;0
WireConnection;13;1;18;0
WireConnection;76;0;11;0
WireConnection;76;1;12;0
WireConnection;76;2;13;0
WireConnection;76;3;14;0
WireConnection;27;0;34;0
WireConnection;27;1;36;2
WireConnection;27;2;36;3
WireConnection;27;3;36;4
WireConnection;66;0;65;0
WireConnection;82;0;52;0
WireConnection;82;1;79;0
WireConnection;79;0;76;0
WireConnection;79;1;78;0
WireConnection;0;0;123;0
WireConnection;70;0;66;0
WireConnection;70;1;82;0
WireConnection;70;2;78;0
WireConnection;123;0;66;0
WireConnection;123;1;70;0
ASEEND*/
//CHKSM=C295830EFFAD0EF03FF49DEB7A1A50BF7E69CAB1
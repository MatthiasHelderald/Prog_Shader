// Made with Amplify Shader Editor v1.9.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Dissolve"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.22
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Cutoff = 0.22;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color7_g1 = IsGammaSpace() ? float4(0.2,0.2,0.2,0) : float4(0.03310476,0.03310476,0.03310476,0);
			float4 color8_g1 = IsGammaSpace() ? float4(0.6980392,0.6980392,0.6980392,0) : float4(0.4452012,0.4452012,0.4452012,0);
			float2 temp_cast_0 = (_Time.y).xx;
			float2 uv_TexCoord5 = i.uv_texcoord * float2( 0.5,0.5 ) + temp_cast_0;
			float2 FinalUV13_g1 = ( float2( 1,1 ) * ( 0.5 + uv_TexCoord5 ) );
			float2 temp_cast_1 = (0.5).xx;
			float2 temp_cast_2 = (1.0).xx;
			float4 appendResult16_g1 = (float4(ddx( FinalUV13_g1 ) , ddy( FinalUV13_g1 )));
			float4 UVDerivatives17_g1 = appendResult16_g1;
			float4 break28_g1 = UVDerivatives17_g1;
			float2 appendResult19_g1 = (float2(break28_g1.x , break28_g1.z));
			float2 appendResult20_g1 = (float2(break28_g1.x , break28_g1.z));
			float dotResult24_g1 = dot( appendResult19_g1 , appendResult20_g1 );
			float2 appendResult21_g1 = (float2(break28_g1.y , break28_g1.w));
			float2 appendResult22_g1 = (float2(break28_g1.y , break28_g1.w));
			float dotResult23_g1 = dot( appendResult21_g1 , appendResult22_g1 );
			float2 appendResult25_g1 = (float2(dotResult24_g1 , dotResult23_g1));
			float2 derivativesLength29_g1 = sqrt( appendResult25_g1 );
			float2 temp_cast_3 = (-1.0).xx;
			float2 temp_cast_4 = (1.0).xx;
			float2 clampResult57_g1 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g1 + 0.25 ) ) - temp_cast_1 ) ) * 4.0 ) - temp_cast_2 ) * ( 0.35 / derivativesLength29_g1 ) ) , temp_cast_3 , temp_cast_4 );
			float2 break71_g1 = clampResult57_g1;
			float2 break55_g1 = derivativesLength29_g1;
			float4 lerpResult73_g1 = lerp( color7_g1 , color8_g1 , saturate( ( 0.5 + ( 0.5 * break71_g1.x * break71_g1.y * sqrt( saturate( ( 1.1 - max( break55_g1.x , break55_g1.y ) ) ) ) ) ) ));
			float4 temp_output_1_0 = lerpResult73_g1;
			o.Albedo = temp_output_1_0.rgb;
			o.Alpha = 1;
			clip( temp_output_1_0.r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19200
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Dissolve;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Custom;0.22;True;True;0;True;TransparentCutout;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.ClipNode;2;-305.844,309.2614;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;3;-310.1285,212.1084;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1;-300.3507,9.34372;Inherit;False;Checkerboard;-1;;1;43dad715d66e03a4c8ad5f9564018081;0;4;1;FLOAT2;0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;4;-766.211,5.12796;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-527.5997,8.608704;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
WireConnection;0;0;1;0
WireConnection;0;10;1;0
WireConnection;1;1;5;0
WireConnection;5;1;4;0
ASEEND*/
//CHKSM=8064EC46B03D3DEA79873F1B522FD4BFAB00B0B6
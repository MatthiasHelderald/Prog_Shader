// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( CustomPostprocessPPSRenderer ), PostProcessEvent.AfterStack, "CustomPostprocess", true )]
public sealed class CustomPostprocessPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "Color" )]
	public ColorParameter _Color = new ColorParameter { value = new Color(1f,1f,1f,1f) };
	[Tooltip( "Albedo (RGB)" )]
	public TextureParameter _MainTex = new TextureParameter {  };
	[Tooltip( "Smoothness" )]
	public FloatParameter _Glossiness = new FloatParameter { value = 0.5f };
	[Tooltip( "Metallic" )]
	public FloatParameter _Metallic = new FloatParameter { value = 0f };
}

public sealed class CustomPostprocessPPSRenderer : PostProcessEffectRenderer<CustomPostprocessPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "Custom/Postprocess" ) );
		sheet.properties.SetColor( "_Color", settings._Color );
		if(settings._MainTex.value != null) sheet.properties.SetTexture( "_MainTex", settings._MainTex );
		sheet.properties.SetFloat( "_Glossiness", settings._Glossiness );
		sheet.properties.SetFloat( "_Metallic", settings._Metallic );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif

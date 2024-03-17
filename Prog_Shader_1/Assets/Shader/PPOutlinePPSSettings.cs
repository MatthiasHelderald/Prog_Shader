// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( PPOutlinePPSRenderer ), PostProcessEvent.AfterStack, "PPOutline", true )]
public sealed class PPOutlinePPSSettings : PostProcessEffectSettings
{
	[Tooltip( "OutlineTickness" )]
	public FloatParameter _OutlineTickness = new FloatParameter { value = 3f };
	[Tooltip( "OutlineColor" )]
	public ColorParameter _OutlineColor = new ColorParameter { value = new Color(1f,1f,1f,0f) };
	[Tooltip( "OutlineIntensity" )]
	public FloatParameter _OutlineIntensity = new FloatParameter { value = 0f };
}

public sealed class PPOutlinePPSRenderer : PostProcessEffectRenderer<PPOutlinePPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "PPOutline" ) );
		sheet.properties.SetFloat( "_OutlineTickness", settings._OutlineTickness );
		sheet.properties.SetColor( "_OutlineColor", settings._OutlineColor );
		sheet.properties.SetFloat( "_OutlineIntensity", settings._OutlineIntensity );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif

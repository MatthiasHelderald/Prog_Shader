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
	[Tooltip( "Float 1" )]
	public FloatParameter _Float1 = new FloatParameter { value = 2.867915f };
	[Tooltip( "Texture Sample 0" )]
	public TextureParameter _TextureSample0 = new TextureParameter {  };
}

public sealed class PPOutlinePPSRenderer : PostProcessEffectRenderer<PPOutlinePPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "PPOutline" ) );
		sheet.properties.SetFloat( "_Float1", settings._Float1 );
		if(settings._TextureSample0.value != null) sheet.properties.SetTexture( "_TextureSample0", settings._TextureSample0 );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif

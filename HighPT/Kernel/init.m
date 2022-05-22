(* ::Package:: *)

(* ::Title:: *)
(*Initialization [HighPT`]*)


(* Generate warning for Mathematica versions earlier than 12.0.0 *)
If[$VersionNumber < 12.0, 
CellPrint[{
TextCell[
"HighPT` was developed for Mathematica 12.0.0 and later. 
Your current Mathematica version [" <> ToString@$Version <> "] might not be compatible. 
In case you are experiencing problems with HighPT`, please update your Mathematica version.",
"Text",Background->LightRed]
}]
]


(* Loading the package *)
If[MemberQ[$Packages,"HighPT`"],
	(* Avoid double loading the package *)
	Print[Style["The package HighPT` is already loaded. Please restart the kernel to reload it.",RGBColor[.8,.4706,0.2573]]],
	
	(* Set directory of XSection package *)
	Clear[$DirectoryHighPT, $LogoHighPT];
	$DirectoryHighPT= DirectoryName[$InputFileName, 2];
	$LogoHighPT= First@ Import[FileNameJoin[{$DirectoryHighPT,"Kernel","logo.pdf"}],"PageGraphics"];

	(* Loading *)
	Check[
		Get[FileNameJoin[{$DirectoryHighPT, "HighPT.m"}]],
		Print[Style["Loading failed!",RGBColor[.6,.0706,0.1373]]];
		Abort[]
	];
	
	CellPrint[ExpressionCell[Style[$LogoHighPT,Magnification->0.6],CellMargins->{{70,5},{5,5}}]];
	
	(* title *)
	Print@ Style[
		Graphics[
			{
				Thickness[0.0025],
				RGBColor[0.04,0.22,0.52],
				Line[{{0,0},{4.5,0}}]
			},
			PlotRange->{{0,4.5},{-0.01,+0.01}}
		],
		Magnification->3
	];
	
	(*
	Print@ TableForm[
	{
		{Style["HighPT",Bold, 18, RGBColor[0.04,0.22,0.52]], Style[":",Bold, 18, RGBColor[0.04,0.22,0.52]], Style["High-\!\(\*SubscriptBox[\(p\), \(T\)]\) Tails", Bold, 16, RGBColor[0.04,0.22,0.52]]},
		{},
		{Style["Authors", Bold, 14], Style[":", Bold, 14], Style["Lukas Allwicher, Darius A. Faroughy, Florentin Jaffredo,", Bold, 14]},
		{"", "", Style["Olcyr Sumensari, and Felix Wilsch", Bold, 14]},
		{Style["Reference", Bold, 14], Style[":", Bold, 14], Style[Hyperlink["arXiv:22xx.xxxxx","https://arxiv.org/", BaseStyle->RGBColor[0.04,0.22,0.52]], Bold, 14]},
		{Style["Website", Bold, 14], Style[":", Bold, 14], Style[Hyperlink["https://github.com/HighPT/HighPT","https://github.com/HighPT/HighPT", BaseStyle->RGBColor[0.04,0.22,0.52]], Bold, 14]}
	}
	];
	*)
	
	(*Print@ Style["HighPT",Bold, 20, RGBColor[0.04,0.22,0.52]];*)
	Print@ Style["Authors: Lukas Allwicher, Darius A. Faroughy, Florentin Jaffredo, Olcyr Sumensari, and Felix Wilsch", Bold, 14];
	Print[
		Style["References: ", Bold, 14],
		Style[Hyperlink["arXiv:22xx.xxxxx","https://arxiv.org/", BaseStyle->RGBColor[0.04,0.22,0.52]], Bold, 14],
		Style[", ", Bold, 14],
		Style[Hyperlink["arXiv:22xx.xxxxx","https://arxiv.org/", BaseStyle->RGBColor[0.04,0.22,0.52]], Bold, 14]
	];
	Print[
		Style["Website: ", Bold, 14], 
		Style[Hyperlink["https://github.com/HighPT/HighPT","https://github.com/HighPT/HighPT", BaseStyle->RGBColor[0.04,0.22,0.52]], Bold, 14]
	];
	
	(* licensing *)
	Print@ Style["HighPT is free software released under the terms of the MIT License.", 12];
	(*
	Print@ Style["Please submit bugs and feature requests using GitHub's issue system at:", 12];
	Print@ Style[Hyperlink["https://github.com/HighPT/HighPT/issues","https://github.com/HighPT/HighPT/issues", BaseStyle->RGBColor[0.04,0.22,0.52]], 12];
	*)
	Print@ Style[
		Graphics[
			{
				Thickness[0.0025],
				RGBColor[0.04,0.22,0.52],
				Line[{{0,0},{4.5,0}}]
			},
			PlotRange->{{0,4.5},{-0.01,+0.01}}
		],
		Magnification->3
	];
	
	(* initialization *)
	(* when loading the package initialize with SMEFT at d=6 with NP^2 contributions *)
	HighPT`InitializeModel["SMEFT", HighPT`EFTorder-> 4, HighPT`OperatorDimension-> 6];
];


(* Protect the symbols used in the package *)
(*
SetAttributes[
  Evaluate @ Flatten[Names /@ {"HighPT`*"}],
  {Protected, ReadProtected}
]
*)

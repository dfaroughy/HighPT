(* ::Package:: *)

Package["HighPT`"]


(* ::Title:: *)
(*HighPTio`Experiments`*)


(* ::Subtitle:: *)
(*Cross-section computation for the semi-leptonic processes pp -> ll and pp -> l\[Nu] in the SMEFT up to order O(\[CapitalLambda]^-4)*)


(* ::Chapter:: *)
(*Public:*)


(* ::Section:: *)
(*Scoping*)


(* ::Subsection:: *)
(*External*)


(*PackageExport["ExperimentInfo"]*)


PackageExport["LHCSearch"]


(* ::Subsection:: *)
(*Internal*)


PackageScope["$SearchDirectories"]


(*PackageScope["GetExperimentData"]*)


(* ::Chapter:: *)
(*Private:*)


$Bins::usage= "$Bins[\"xxx\"] gives the experimental bins for the \"xxx\" final state."


$NEventsObserved::usage= "$NEventsObserved[\"xxx\"] gives the number of events observed by the experiment for the \"xxx\" final state."


$NEventsPredicted::usage= "$NEventsPredicted[\"xxx\"] gives SM expectation value for the observed number of events for the \"xxx\" final state as reported by the experiment."


$NEventsUncertainty::usage= "$NEventsUncertainty[\"xxx\"] ";


(* ::Section:: *)
(*Loading the experimental results*)


LoadExperimentalResults::usage= "LoadExperimentalResults[] loads all experiemntal measurements.";


LoadExperimentalResults[str_String]:= Get@FileNameJoin[{Global`$DirectoryHighPT, "LHC_searches", str, str<>".dat"}];


(*
LoadExperimentalResults[str_String]:= Module[
	{}
	,
	Get@FileNameJoin[{Global`$DirectoryHighPT, "experimental_data", str<>".dat"}];
	$NEventsObserved[str]= $NEventsObserved[str]/.(a_/;Negative[a]->Nothing);
	$NEventsSM[str]= $NEventsSM[str]/.{0.->Nothing, (a_/;Negative[a]->Nothing)};
]
*)


(* ::Section:: *)
(*Returning the experimental results*)


(*GetExperimentData::usage= "GetExperimentData[\"proc\"]
	Loads the experimental results and returns them as an association.";*)


(*GetExperimentData[proc_String]:= Module[{},
	(* load the proc.dat file *)
	LoadExperimentalResults[proc];
	GetExperimentData[proc]= <|
		"Bins"     -> $Bins[proc],
		"Observed" -> $NEventsObserved[proc],
		"SM"       -> $NEventsSM[proc]
	|>
]*)


(* ::Section:: *)
(*Returning info about experiments*)


(*ExperimentInfo::usage= "ExperimentInfo[\"proc\"]
	Returns an Association containing all the experimental information for the given process.
	The argument \"proc\" specifies the given process, e.g. \"proc\"=\"tata\" for the process pp \[Rule] \!\(\*SuperscriptBox[\(\[Tau]\), \(-\)]\)\!\(\*SuperscriptBox[\(\[Tau]\), \(+\)]\).";*)


(*ExperimentInfo::procunknown= "No experimental data found for the specified process `1`.";*)


(*ExperimentInfo[proc_String]:= Module[
	{obs, collab, arxiv, obsBins, mllBins, ptBins, lumi, return}
	,
	Switch[proc,
		"tata",
			obs= "\!\(\*SubsuperscriptBox[m, T, tot]\)";
			collab= "ATLAS";
			arxiv= Hyperlink["2002.12223", "https://arxiv.org/abs/2002.12223"];
			lumi = 139;
			obsBins= GetExperimentData[proc]["Bins"];
			mllBins= {150, 200, 250, 300, 350, 400, 450, 500, 600, 700, 800, 900, 1000, 1150, 1500}; (* check the last bin *)
			ptBins= {0, \[Infinity]},
		(* add more processes here *)
		_,
			Message[ExperimentInfo::procunknown, proc];
			Abort[]
	];
	
	return= <|
		"PROCESS"    -> proc,
		"EXPERIMENT" -> collab,
		"ARXIV"      -> arxiv,
		"OBSERVABLE" -> obs,
		"BINNING"    -> obsBins,
		"LUMINOSITY" -> lumi
	|>;
	
	Return[return]
]*)


(* ::Section:: *)
(*LHCSearch*)


LHCSearch::usage= "LHCSearch[]
	Lists all LHC searches that are available for the analysis.

LHCSearch[\"proc\"]
	Loads and returns all available date for the LHC search specified by the string \"proc\" as an association."


LHCSearch[str_String]:= Module[{proc=str},
	(* use alias if available *)
	If[KeyExistsQ[$Searches, str], proc= $SearchDirectories[str]];
	(* Load experimental results *)
	LoadExperimentalResults[proc];
	(* set experimental data *)
	LHCSearch[str]= <|
		"Info"     -> $Info[proc],
		"Observed" -> $NEventsObserved[proc],
		"Expected" -> $NEventsPredicted[proc],
		"Error"    -> $NEventsUncertainty[proc]
	|>
]


LHCSearch[]:= $Searches


(* ::Section:: *)
(*Searches*)


(* ::Subsection:: *)
(*List of all available searches*)


$Searches= <|
	"di-tau-ATLAS"        -> Hyperlink["arXiv:2002.12223", "https://arxiv.org/abs/2002.12223"],
	(*
	"di-muon-CMS"           -> "",
	"di-electron-CMS"       -> "",
	*)
	"mono-tau-ATLAS"      -> Hyperlink["ATLAS-CONF-2021-025", "https://cds.cern.ch/record/2773301/"],
	"mono-muon-ATLAS"     -> Hyperlink["arXiv:1906.05609", "https://arxiv.org/abs/1906.05609"],
	"mono-electron-ATLAS" -> Hyperlink["arXiv:1906.05609", "https://arxiv.org/abs/1906.05609"],
	"muon-tau-CMS"        -> Hyperlink["CMS-PAS-EXO-19-014", "https://cds.cern.ch/record/2779023"],
	"electron-tau-CMS"    -> Hyperlink["CMS-PAS-EXO-19-014", "https://cds.cern.ch/record/2779023"],
	"electron-muon-CMS"   -> Hyperlink["CMS-PAS-EXO-19-014", "https://cds.cern.ch/record/2779023"]
|>


(* ::Subsection:: *)
(*internal labeling of the searches*)


$SearchDirectories= <|
	"di-tau-ATLAS"        -> "di-tau_ATLAS_2002_12223",
	(*
	"di-muon-CMS"           -> "",
	"di-electron-CMS"       -> "",
	*)
	"mono-tau-ATLAS"      -> "mono-tau_ATLAS-CONF-2021-025",
	"mono-muon-ATLAS"     -> "mono-muon_ATLAS_1906_05609",
	"mono-electron-ATLAS" -> "mono-electron_ATLAS_1906_05609",
	
	"muon-tau-CMS"        -> "muon-tau_CMS-PAS-EXO-19-014",
	"electron-tau-CMS"    -> "electon-tau_CMS-PAS-EXO-19-014",
	"electron-muon-CMS"   -> "electon-muon_CMS-PAS-EXO-19-014"
|>

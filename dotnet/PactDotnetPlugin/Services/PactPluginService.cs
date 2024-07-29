using Grpc.Core;
using Google.Protobuf.WellKnownTypes;
using Google.Protobuf;

namespace GrpcPactPlugin.Services;

public class PactPluginService : PactPlugin.PactPluginBase
{
    private readonly ILogger<PactPluginService> _logger;
    public PactPluginService(ILogger<PactPluginService> logger)
    {
        _logger = logger;
    }

    public override Task<InitPluginResponse> InitPlugin(
        InitPluginRequest request, ServerCallContext context)
    {
        var response = new InitPluginResponse();
        var contentTypes = new Dictionary<string, string>();
        contentTypes.Add("content-types", "application/foo");
        var catalogueEntries = new[] { new CatalogueEntry
                                        { Key = "foo",
                                        Type = (CatalogueEntry.Types.EntryType)0,
                                        Values = { contentTypes } } };
        response.Catalogue.Add(catalogueEntries);

        return Task.FromResult(
            response
        );
    }
    public override Task<Empty> UpdateCatalogue(
        Catalogue request, ServerCallContext context)
    { return Task.FromResult(new Empty()); }
    public override Task<ConfigureInteractionResponse> ConfigureInteraction(
        ConfigureInteractionRequest request, ServerCallContext context)


    {
        Console.WriteLine("ConfigureInteraction started.", request);
        var configureInteractionResponse = new ConfigureInteractionResponse();
        var interactionResponse = new InteractionResponse();
        if (request.ContentsConfig.Fields.ContainsKey("request"))
        {
            interactionResponse.PartName = "request";
            var interactionRequestContent = new Body();
            interactionRequestContent.ContentType = "application/foo";
            interactionRequestContent.Content = ByteString.CopyFromUtf8("hello");
            interactionResponse.Contents = interactionRequestContent;
            configureInteractionResponse.Interaction.Add(interactionResponse);
            return Task.FromResult(configureInteractionResponse);
        }

        if (request.ContentsConfig.Fields.ContainsKey("response"))
        {

            interactionResponse.PartName = "response";
            var interactionResponseContent = new Body();
            interactionResponseContent.ContentType = "application/foo";
            interactionResponseContent.Content = ByteString.CopyFromUtf8("world");
            interactionResponse.Contents = interactionResponseContent;
            configureInteractionResponse.Interaction.Add(interactionResponse);
            return Task.FromResult(configureInteractionResponse);
        }
        return Task.FromResult(configureInteractionResponse);
    }
    public override Task<CompareContentsResponse> CompareContents(
        CompareContentsRequest request, ServerCallContext context)
    {
        var response = new CompareContentsResponse();
        var actual = request.Actual.Content;
        var expected = request.Expected.Content;
        if (actual != expected)
        {
            var contentMismatches = new ContentMismatches();
            var contentMismatch = new ContentMismatch();
            contentMismatch.Actual = actual;
            contentMismatch.Expected = expected;
            contentMismatch.Diff = "diff";
            contentMismatch.Path = "$";
            contentMismatch.Mismatch = $"expected body {expected.ToStringUtf8()} is not equal to actual body {actual.ToStringUtf8()}";
            contentMismatches.Mismatches.Add(contentMismatch);
            var contentMismatchDict = new Dictionary<string, ContentMismatches>();
            contentMismatchDict.Add("$", contentMismatches);
            response.Results.Add(contentMismatchDict);
            response.Error = "actual does not meet expected";
            var contentTypeMismatch = new ContentTypeMismatch();
            contentTypeMismatch.Actual = actual.ToStringUtf8();
            contentTypeMismatch.Expected = expected.ToStringUtf8();
            response.TypeMismatch = contentTypeMismatch;
        }


        return Task.FromResult(response);
    }

    public override Task<GenerateContentResponse> GenerateContent(
        GenerateContentRequest request, ServerCallContext context)
    { return Task.FromResult(new GenerateContentResponse()); }
    public override Task<StartMockServerResponse> StartMockServer(
        StartMockServerRequest request, ServerCallContext context)
    { return Task.FromResult(new StartMockServerResponse()); }
    public override Task<ShutdownMockServerResponse> ShutdownMockServer(
        ShutdownMockServerRequest request, ServerCallContext context)
    { return Task.FromResult(new ShutdownMockServerResponse()); }
    public override Task<MockServerResults> GetMockServerResults(
        MockServerRequest request, ServerCallContext context)
    { return Task.FromResult(new MockServerResults()); }
    public override Task<VerificationPreparationResponse> PrepareInteractionForVerification(
        VerificationPreparationRequest request, ServerCallContext context)
    { return Task.FromResult(new VerificationPreparationResponse()); }
    public override Task<VerifyInteractionResponse> VerifyInteraction(
        VerifyInteractionRequest request, ServerCallContext context)
    { return Task.FromResult(new VerifyInteractionResponse()); }
}

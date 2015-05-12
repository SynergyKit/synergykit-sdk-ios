<h1 id="synergykit-ios-sdk">SynergyKit iOS SDK</h1>

<p align="left">
<img src="https://synergykit.blob.core.windows.net/synergykit/synergykitlogo.png" alt="Synergykit" title="Synergykit" width="224px">
</p>

<p><a href="http://cocoadocs.org/docsets/SynergyKit-SDK"><img src="https://img.shields.io/cocoapods/v/SynergyKit-SDK.svg?style=flat" alt="Version" title=""></a> <a href="http://cocoadocs.org/docsets/SynergyKit-SDK"><img src="https://img.shields.io/cocoapods/l/SynergyKit-SDK.svg?style=flat" alt="License" title=""></a> <a href="http://cocoadocs.org/docsets/SynergyKit-SDK"><img src="https://img.shields.io/cocoapods/p/SynergyKit-SDK.svg?style=flat" alt="Platform" title=""></a></p>

<p>Letsgood.com runs Backend as a Service SynergyKit for <strong>fast and simple mobile/web/desktop applications development</strong>. SynergyKit allows enterpreneurs implement an idea to project fast and at low cost like Lean Startup.</p>

<p>We know how hard can be to work with untried API, so we prepared SDKs for mostly used platforms.</p>

<p><strong>Another SDKs</strong></p>

<ul>
<li><a href="https://github.com/SynergyKit/synergykit-sdk-android">Android SDK</a></li>
<li><a href="https://github.com/SynergyKit/synergykit-sdk-nodejs">Node.js SDK</a></li>
<li><a href="https://github.com/SynergyKit/synergykit-sdk-javascript">JavaScript SDK</a></li>
</ul>

<p><strong>Table of content</strong></p>

<p><div class="toc">
<ul>
<li><a href="#synergykit-ios-sdk">SynergyKit iOS SDK</a><ul>
<li><a href="#sample-application">Sample Application</a><ul>
<li><a href="#sample-app-installation">Sample App Installation</a></li>
</ul>
</li>
<li><a href="#sdk-installation">SDK Installation</a></li>
<li><a href="#architecture">Architecture</a><ul>
<li><a href="#building-a-model">Building a model</a><ul>
<li><a href="#examples">Examples</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#synergykit-initialization">SynergyKit Initialization</a></li>
<li><a href="#responses-handling">Responses handling</a></li>
<li><a href="#documents">Documents</a><ul>
<li><a href="#create-new-document">Create new document</a></li>
<li><a href="#retrieve-an-existing-document-by-id">Retrieve an existing document by ID</a></li>
<li><a href="#update-document">Update document</a></li>
<li><a href="#delete-document">Delete document</a></li>
</ul>
</li>
<li><a href="#real-time-data-observerving">Real-time data observerving</a><ul>
<li><a href="#checking-connection-state">Checking connection state</a></li>
<li><a href="#start-observing-whole-collection">Start observing whole collection</a></li>
<li><a href="#start-observing-collection-with-filter">Start observing collection with filter</a></li>
<li><a href="#stop-observing">Stop observing</a></li>
<li><a href="#speak-communication">Speak communication</a><ul>
<li><a href="#send-speak">Send speak</a></li>
<li><a href="#receive-speak">Receive speak</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#queries">Queries</a><ul>
<li><a href="#available-conditions">Available conditions</a><ul>
<li><a href="#filter">filter</a></li>
<li><a href="#startswith">startswith</a></li>
<li><a href="#endswith">endswith</a></li>
<li><a href="#substringof">substringof</a></li>
<li><a href="#in">in</a></li>
<li><a href="#nin">nin</a></li>
<li><a href="#select">select</a></li>
<li><a href="#top">top</a></li>
<li><a href="#orderby">orderby</a></li>
<li><a href="#inlinecount">inlinecount</a></li>
<li><a href="#skip">skip</a></li>
</ul>
</li>
<li><a href="#querying-objects">Querying objects</a></li>
<li><a href="#list-all-users">List all users</a></li>
<li><a href="#list-all-documents">List all documents</a></li>
<li><a href="#list-all-files">List all files</a></li>
</ul>
</li>
<li><a href="#users">Users</a><ul>
<li><a href="#create-a-new-user">Create a new user</a></li>
<li><a href="#retrieve-an-existing-user-by-id">Retrieve an existing user by ID</a></li>
<li><a href="#update-user">Update user</a></li>
<li><a href="#delete-user">Delete user</a></li>
<li><a href="#add-role">Add role</a></li>
<li><a href="#remove-role">Remove role</a></li>
<li><a href="#add-platform-to-user">Add platform to user</a></li>
<li><a href="#retrive-platform">Retrive platform</a></li>
<li><a href="#update-platform">Update platform</a></li>
<li><a href="#delete-platform">Delete platform</a></li>
<li><a href="#activating-user">Activating user</a></li>
<li><a href="#login-user">Login user</a></li>
</ul>
</li>
<li><a href="#communication">Communication</a><ul>
<li><a href="#send-notification">Send notification</a></li>
<li><a href="#send-e-mail">Send e-mail</a></li>
</ul>
</li>
<li><a href="#files">Files</a><ul>
<li><a href="#upload-file">Upload file</a></li>
<li><a href="#retrieve-file-by-id">Retrieve file by ID</a></li>
<li><a href="#delete-file">Delete file</a></li>
</ul>
</li>
<li><a href="#cloud-code">Cloud Code</a><ul>
<li><a href="#run-cloud-code">Run cloud code</a></li>
</ul>
</li>
<li><a href="#batch-request">Batch request</a><ul>
<li><a href="#sbatchitem">SBatchItem</a></li>
<li><a href="#sbatchitemwrapper">SBatchItemWrapper</a></li>
<li><a href="#sbatch">SBatch</a></li>
<li><a href="#using-batch">Using batch</a></li>
</ul>
</li>
<li><a href="#cache">Cache</a><ul>
<li><a href="#scachetypecacheelseload">SCacheTypeCacheElseLoad</a></li>
<li><a href="#scachetypeloadelsecache">SCacheTypeLoadElseCache</a></li>
<li><a href="#expiration-of-cached-data">Expiration of cached data</a></li>
</ul>
</li>
<li><a href="#changelog">Changelog</a><ul>
<li><a href="#version-210-22-4-2015">Version 2.1.0 (22. 4. 2015)</a></li>
</ul>
</li>
<li><a href="#author">Author</a></li>
<li><a href="#license">License</a></li>
</ul>
</li>
</ul>
</div>
</p>

<h2 id="sample-application">Sample Application</h2>

<p>Almost all possibilities of SynergyKit are presented in Sample Application that was developed next to SDK as introduction of how it works.</p>



<h3 id="sample-app-installation">Sample App Installation</h3>

<ol>
<li><p>Clone or download the repository. <br>
<code>git clone https://github.com/SynergyKit/synergykit-sdk-ios</code></p></li>
<li><p>Go to SampleApp folder in Terminal.</p></li>
<li><p>Install pods (<strong>CocoaPods required</strong>). <br>
<code>pod install</code></p></li>
<li><p>Open .xcworkspace file. <br>
<code>open sampleapp.xcworkspace</code></p></li>
</ol>

<h2 id="sdk-installation">SDK Installation</h2>

<p><strong>SynergyKit-SDK</strong> is available through <a href="http://cocoapods.org/pods/SynergyKit-SDK">CocoaPods</a>. To install it, simply add the following line to your Podfile:</p>

<p><code>pod 'SynergyKit-SDK'</code></p>



<h2 id="architecture">Architecture</h2>



<h3 id="building-a-model">Building a model</h3>

<p>Building of data model is one of the most important activity in application development.</p>

<p>If you want to use SynergyKit SDK for development, you need to start with subclassing of <code>SynergykitObject</code> in data model. <code>SynergykitObject</code> contains <em>must have</em> properties for communication with SynergyKit - _id, __v,  createdAt and updatedAt. It also conforms to <code>SynergykitProtocol</code>,  <code>SBatchableProtocol</code> and <code>SCacheableProtocol</code> that simplify cooperation with SynergyKit.</p>

<p><code>SynergykitObject</code> serialization and deserialization is based on <a href="http://www.jsonmodel.com">JSONModel</a>. Marin Todorov - author of JSONModel - presents nice examples of magic modelling framework on <a href="https://github.com/icanzilb/JSONModel/#examples">github framework page here</a>.</p>

<p><strong>Be afraid of writing model in Swift. Swift is not fully supported with JSONModel.</strong></p>



<h4 id="examples">Examples</h4>

<table>
<tbody>
<tr>
<td valign="top">
<pre>{
  "author": "Mr. Synergykit",
  "name": "Building model,
  "price": 9.5
}
</pre>
</td>
<td>
<pre>@interface BookModel : SynergykitObject
@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) float price;
@end

@implementation BookModel
@end
</pre>
</td>
</tr>
</tbody>
</table>

<p>If your object has property that isnâ€™t synchronized with server, just say that conforms to protocol <code>Optional</code> or <code>Ignore</code>. These protocols are <strong>important for deserialization</strong> because JSON string must contain all properties <em>without</em> these protocols. <a href="https://github.com/icanzilb/JSONModel/blob/master/README.md#optional-properties-ie-can-be-missing-or-null">More information about JSONModel protocols</a>.</p>

<table>
<tbody>
<tr>
<td valign="top">
<pre>{
  "author": "Mr. Synergykit",
  "name": "Building model,
  "price": 9.5
}
</pre>
</td>
<td>
<pre>@interface BookModel : SynergykitObject
@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) float price;
@property (strong, nonatomic) NSString<b>&lt;Optional&gt;</b>* category;
@property (strong, nonatomic) NSNumber<b>&lt;Ignore&gt;* </b>order;
@end

@implementation BookModel
@end
</pre>
</td>
</tr>
</tbody>
</table>



<h2 id="synergykit-initialization">SynergyKit Initialization</h2>

<p>If installation process have been done, itâ€™s time for basic setup. There are required options as tenant and key and one optional - enable debugging.</p>

<p>Tenant and key are situated in <strong>Settings &gt; Application keys &gt; Tenant</strong> and <strong>Settings &gt; Application keys &gt; Value</strong> in Synergykit web application.</p>



<pre class="prettyprint"><code class="language-objective-c hljs ini"><span class="hljs-title">[Synergykit setTenant:@"tenant" key:@"key"]</span><span class="hljs-comment">;</span>
<span class="hljs-title">[Synergykit enableDebugging:YES]</span><span class="hljs-comment">;</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs vbnet">Synergykit.setTenant(<span class="hljs-string">"tenant"</span>, <span class="hljs-keyword">key</span>: <span class="hljs-string">"key"</span>)
Synergykit.enableDebugging(<span class="hljs-literal">true</span>)</code></pre>



<h2 id="responses-handling">Responses handling</h2>

<p>There are many options that you can receive at the end of API communication. SDK wraps these API responses in <code>SResponse</code> or <code>SResponseWrapper</code> according to request type.</p>

<p>Basic requests with only one object in return response as <code>SResponse</code> object, which could be handled this way.</p>



<pre class="prettyprint"><code class="language-objective-c hljs applescript">^(SResponse *<span class="hljs-constant">result</span>) {
    <span class="hljs-keyword">if</span> ([<span class="hljs-constant">result</span> succeeded])
  {
      YourType *successObject = (YourType *) <span class="hljs-constant">result</span>;
  }
  <span class="hljs-keyword">else</span>
  {
      NSError *errorObject = <span class="hljs-constant">result</span>.<span class="hljs-keyword">error</span>
  }
}
</code></pre>



<pre class="prettyprint"><code class="language-swift hljs applescript">{
    (<span class="hljs-constant">result</span> : SResponse!) -&gt; Void <span class="hljs-keyword">in</span>
  <span class="hljs-keyword">if</span> <span class="hljs-constant">result</span>.succeeded()
  {
      let successObject = <span class="hljs-constant">result</span>.<span class="hljs-constant">result</span> <span class="hljs-keyword">as</span> YourType
  }
  <span class="hljs-keyword">else</span>
  {
      let errorObject = <span class="hljs-constant">result</span>.<span class="hljs-keyword">error</span>
  }
}</code></pre>

<p>Complex requests with more than one object in return response as <code>SResponseWrapper</code> object.</p>



<pre class="prettyprint"><code class="language-objective-c hljs cs">^(SResponseWrapper *results) {
  <span class="hljs-keyword">if</span> ([results succeeded])
  {
      <span class="hljs-keyword">for</span> (YourType *response <span class="hljs-keyword">in</span> results.results)
      {
        <span class="hljs-comment">// Handle response</span>
      }
  }
  <span class="hljs-keyword">else</span>
  {
      <span class="hljs-keyword">for</span> (NSError *response <span class="hljs-keyword">in</span> results.results)
      {
          <span class="hljs-comment">// Handle error</span>
      }
  }
}</code></pre>



<pre class="prettyprint"><code class="language-swift hljs cs">{
    (results : SResponseWrapper!) -&gt; Void <span class="hljs-keyword">in</span>
  <span class="hljs-keyword">if</span> results.succeeded()
  {
      <span class="hljs-keyword">for</span> response <span class="hljs-keyword">in</span> results.results() <span class="hljs-keyword">as</span> [YourType]
      {
        <span class="hljs-comment">// Handle response</span>
      }
  }
  <span class="hljs-keyword">else</span>
  {
      <span class="hljs-keyword">for</span> error <span class="hljs-keyword">in</span> results.errors()
      {
          <span class="hljs-comment">// Handle error</span>
      }
  }
}</code></pre>



<h2 id="documents">Documents</h2>

<p>Documents are data saved in collections. Collections are basically tables in database where you can store your data. By sending requests to the documents endpoint, you can list, create, update or delete documents.</p>



<h3 id="create-new-document">Create new document</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">collection</td>
  <td align="left">NSString</td>
  <td align="left">Location of document</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">*</td>
  <td align="left">?</td>
  <td align="left">Optional parameters</td>
  <td align="center">optional</td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs haskell"><span class="hljs-type">SynergykitObject</span> *<span class="hljs-typedef"><span class="hljs-keyword">data</span> = [[<span class="hljs-type">SynergykitObject</span> alloc] initWithCollection:@"target-collection"];</span>

[<span class="hljs-typedef"><span class="hljs-keyword">data</span> save:^<span class="hljs-container">(<span class="hljs-type">SResponse</span> *<span class="hljs-title">result</span>)</span> <span class="hljs-container">{
   // <span class="hljs-type">Handle</span> <span class="hljs-title">result</span>
}</span>];</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs lasso"><span class="hljs-keyword">let</span> <span class="hljs-built_in">data</span> <span class="hljs-subst">=</span> SynergykitObject(collection: <span class="hljs-string">"target-collection"</span>)

<span class="hljs-built_in">data</span><span class="hljs-built_in">.</span>save {
    (result : SResponse<span class="hljs-subst">!</span>) <span class="hljs-subst">-&gt; </span><span class="hljs-literal">Void</span> <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle result</span>
}</code></pre>



<h3 id="retrieve-an-existing-document-by-id">Retrieve an existing document by ID</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">collection</td>
  <td align="left">NSString</td>
  <td align="left">Location of document</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs haskell"><span class="hljs-type">SynergykitObject</span> *<span class="hljs-typedef"><span class="hljs-keyword">data</span> = [[<span class="hljs-type">SynergykitObject</span> alloc] initWithCollection:@"target-collection" _id:@"<span class="hljs-keyword">data</span>-id"];</span>

[<span class="hljs-typedef"><span class="hljs-keyword">data</span> fetch:^<span class="hljs-container">(<span class="hljs-type">SResponse</span> *<span class="hljs-title">result</span>)</span> <span class="hljs-container">{
    // <span class="hljs-type">Handle</span> <span class="hljs-title">result</span>
}</span>];</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs lasso"><span class="hljs-keyword">let</span> <span class="hljs-built_in">data</span> <span class="hljs-subst">=</span> SynergykitObject(collection: <span class="hljs-string">"target-collection"</span>, _id: <span class="hljs-string">"data-id"</span>)

<span class="hljs-built_in">data</span><span class="hljs-built_in">.</span>fetch {
    (result : SResponse<span class="hljs-subst">!</span>) <span class="hljs-subst">-&gt; </span><span class="hljs-literal">Void</span> <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle result</span>
}</code></pre>



<h3 id="update-document">Update document</h3>

<p>Save method executes <code>PUT</code> request if <code>_id</code> is set.</p>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">collection</td>
  <td align="left">NSString</td>
  <td align="left">Location of document</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">*</td>
  <td align="left">?</td>
  <td align="left">Optional parameters</td>
  <td align="center">optional</td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs haskell"><span class="hljs-type">SynergykitObject</span> *<span class="hljs-typedef"><span class="hljs-keyword">data</span> = [[<span class="hljs-type">SynergykitObject</span> alloc] initWithCollection:@"target-collection" _id:@"<span class="hljs-keyword">data</span>-id"];</span>

[<span class="hljs-typedef"><span class="hljs-keyword">data</span> save:^<span class="hljs-container">(<span class="hljs-type">SResponse</span> *<span class="hljs-title">result</span>)</span> <span class="hljs-container">{
   // <span class="hljs-type">Handle</span> <span class="hljs-title">result</span>
}</span>];</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs lasso"><span class="hljs-keyword">let</span> <span class="hljs-built_in">data</span> <span class="hljs-subst">=</span> SynergykitObject(collection: <span class="hljs-string">"target-collection"</span>, _id: <span class="hljs-string">"data-id"</span>)

<span class="hljs-built_in">data</span><span class="hljs-built_in">.</span>save {
    (result : SResponse<span class="hljs-subst">!</span>) <span class="hljs-subst">-&gt; </span><span class="hljs-literal">Void</span> <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle result</span>
}</code></pre>



<h3 id="delete-document">Delete document</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">collection</td>
  <td align="left">NSString</td>
  <td align="left">Location of document</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs haskell"><span class="hljs-type">SynergykitObject</span> *<span class="hljs-typedef"><span class="hljs-keyword">data</span> = [[<span class="hljs-type">SynergykitObject</span> alloc] initWithCollection:@"target-collection" _id:@"<span class="hljs-keyword">data</span>-id"];</span>

[<span class="hljs-typedef"><span class="hljs-keyword">data</span> destroy:^<span class="hljs-container">(<span class="hljs-type">SResponse</span> *<span class="hljs-title">result</span>)</span> <span class="hljs-container">{
   // <span class="hljs-type">Handle</span> <span class="hljs-title">result</span>
}</span>];</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs lasso"><span class="hljs-keyword">let</span> <span class="hljs-built_in">data</span> <span class="hljs-subst">=</span> SynergykitObject(collection: <span class="hljs-string">"target-collection"</span>, _id: <span class="hljs-string">"data-id"</span>)

<span class="hljs-built_in">data</span><span class="hljs-built_in">.</span>destroy {
    (result : SResponse<span class="hljs-subst">!</span>) <span class="hljs-subst">-&gt; </span><span class="hljs-literal">Void</span> <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle result</span>
}</code></pre>



<h2 id="real-time-data-observerving">Real-time data observerving</h2>

<p>SDK supports real time communication through sockets. You can observe these types of changes.</p>

<ul>
<li>POST as <code>SMethodTypePOST</code></li>
<li>PUT as <code>SMethodTypePUT</code></li>
<li>PATCH as <code>SMethodTypePATCH</code></li>
<li>DELETE as <code>SMethodTypeDELETE</code></li>
</ul>

<p><code>SObserver</code> can listen changes in whole collection or in a filtered area. </p>



<h3 id="checking-connection-state">Checking connection state</h3>

<p>Real-time connection state could be handled in delegate method <code>observingConnectionDidChangeState</code>.</p>



<pre class="prettyprint"><code class="language-objective-c hljs ini"><span class="hljs-title">[SObserver connectionDelegate:self]</span><span class="hljs-comment">;</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs ruby"><span class="hljs-constant">SObserver</span>.connectionDelegate(<span class="hljs-keyword">self</span>)</code></pre>



<h3 id="start-observing-whole-collection">Start observing whole collection</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">object</td>
  <td align="left">SynergykitObject</td>
  <td align="left">Determines location and return type</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">event</td>
  <td align="left">SMethodType</td>
  <td align="left">Listen changes on event</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SynergykitObject *<span class="hljs-keyword">object</span> = [[SynergykitObject alloc] initWithCollection:<span class="hljs-string">@"target-collection"</span>];

SObserver *observer = [[SObserver alloc] initWithObject:<span class="hljs-keyword">object</span> <span class="hljs-keyword">event</span>:SMethodTypePOST];

[observer startObservingWithObjectHandler:^(id result) {
    <span class="hljs-comment">// Handle received object</span>
} stateHandler:^(SObserverState state, NSArray *errors) {
    <span class="hljs-comment">// Handle changed state</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs cs"><span class="hljs-keyword">let</span> <span class="hljs-keyword">object</span> = SynergykitObject(collection: <span class="hljs-string">"target-collection"</span>)

<span class="hljs-keyword">let</span> observer = SObserver(<span class="hljs-keyword">object</span>: <span class="hljs-keyword">object</span>, <span class="hljs-keyword">event</span>: SMethodType.POST)

observer.startObservingWithObjectHandler({
    (result : AnyObject!) -&gt; Void <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle received object</span>
}, stateHandler: {
    (state : SObserverState, args : [AnyObject]!) -&gt; Void <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle changed state</span>
})</code></pre>



<h3 id="start-observing-collection-with-filter">Start observing collection with filter</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">object</td>
  <td align="left">SynergykitObject</td>
  <td align="left">Determines location and return type</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">query</td>
  <td align="left">SQuery</td>
  <td align="left">Sets observerving condition</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">event</td>
  <td align="left">SMethodType</td>
  <td align="left">Event to be listened</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SynergykitObject *<span class="hljs-keyword">object</span> = [[SynergykitObject alloc] initWithCollection:<span class="hljs-string">@"target-collection"</span>];

SQuery *query = [[SQuery alloc] initWithObject:<span class="hljs-keyword">object</span>];
[query filterField:<span class="hljs-string">@"player"</span> relationOperator:<span class="hljs-string">@"=="</span> <span class="hljs-keyword">value</span>:<span class="hljs-string">@"knight"</span>];

SObserver *observer = [[SObserver alloc] initWithObject:query queryName:<span class="hljs-string">@"knight"</span> <span class="hljs-keyword">event</span>:SMethodTypePOST];

[observer startObservingWithObjectHandler:^(id result) {
    <span class="hljs-comment">// Handle received object</span>
} stateHandler:^(SObserverState state, NSArray *errors) {
    <span class="hljs-comment">// Handle changed state</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs cs"><span class="hljs-keyword">let</span> <span class="hljs-keyword">object</span> = SynergykitObject(collection: <span class="hljs-string">"target-collection"</span>)

<span class="hljs-keyword">let</span> query = SQuery(<span class="hljs-keyword">object</span>: <span class="hljs-keyword">object</span>)
query.filterField(<span class="hljs-string">"player"</span>, relationOperator: <span class="hljs-string">"=="</span>, <span class="hljs-keyword">value</span>: <span class="hljs-string">"knight"</span>)

<span class="hljs-keyword">let</span> observer = SObserver(<span class="hljs-keyword">object</span>: query, queryName: <span class="hljs-string">"knight"</span>, <span class="hljs-keyword">event</span>: SMethodType.POST)

observer.startObservingWithObjectHandler({
    (result : AnyObject!) -&gt; Void <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle received object</span>
}, stateHandler: {
    (state : SObserverState, args : [AnyObject]!) -&gt; Void <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle changed state</span>
})</code></pre>



<h3 id="stop-observing">Stop observing</h3>



<pre class="prettyprint"><code class="language-objective-c hljs ini"><span class="hljs-title">[observer stopObserving]</span><span class="hljs-comment">;</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs avrasm">observer<span class="hljs-preprocessor">.stopObserving</span>()</code></pre>

<p>Or if you have no reference on instance you can stop all observers by calling one method.</p>



<pre class="prettyprint"><code class="language-objective-c hljs ini"><span class="hljs-title">[SObserver stopAllObservers]</span><span class="hljs-comment">;</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs avrasm">SObserver<span class="hljs-preprocessor">.stopAllObservers</span>()</code></pre>



<h3 id="speak-communication">Speak communication</h3>

<p>Communication without data storage from device to device.</p>



<h4 id="send-speak">Send speak</h4>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">speakName</td>
  <td align="left">NSString</td>
  <td align="left">Name of the speak</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">object</td>
  <td align="left">SynergykitObject</td>
  <td align="left">Object that will be transmitted</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs perl">SObserver <span class="hljs-variable">*observer</span> = [[SObserver alloc] initWithSpeakName:<span class="hljs-variable">@"</span>typing<span class="hljs-string">"];

SynergykitUser <span class="hljs-variable">*user</span> = [SynergykitUser new];
user.email = <span class="hljs-variable">@"</span>development<span class="hljs-variable">@synergykit</span>.com"</span>;

[observer speakWithObject:user];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs bash"><span class="hljs-built_in">let</span> observer = SObserver(speakName: <span class="hljs-string">"typing"</span>)

<span class="hljs-built_in">let</span> user = SynergykitUser()
user.email = <span class="hljs-string">"development@synergykit.com"</span>

observer.speakWithObject(user)</code></pre>



<h4 id="receive-speak">Receive speak</h4>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">speakName</td>
  <td align="left">NSString</td>
  <td align="left">Name of the speak</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs objectivec">SObserver *observer = [[SObserver alloc] initWithSpeakName:@<span class="hljs-string">"typing"</span>];

[observer startObservingWithObjectHandler:^(<span class="hljs-keyword">id</span> result) {
    <span class="hljs-comment">// Handle received object</span>
} stateHandler:^(SObserverState state, <span class="hljs-built_in">NSArray</span> *errors) {
    <span class="hljs-comment">// Handle changed state</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> observer = SObserver(<span class="hljs-attribute">speakName</span>: <span class="hljs-string">"typing"</span>)

observer.startObservingWithObjectHandler({
    <span class="hljs-function"><span class="hljs-params">(result : AnyObject!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
    <span class="hljs-regexp">//</span> Handle received object
}, <span class="hljs-attribute">stateHandler</span>: {
    <span class="hljs-function"><span class="hljs-params">(state : SObserverState, args : [AnyObject]!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
    <span class="hljs-regexp">//</span> Handle changed state
})</code></pre>



<h2 id="queries">Queries</h2>

<p>You can retrieve multiple objects at once by sending a request with query. If query has no conditions API returns simply lists of all objects in collection.</p>

<p>For more complex filtering and sorting SynergyKit accepts OData standard. These queries can be used with data, users and files.</p>



<h3 id="available-conditions">Available conditions</h3>

<p>Query string is builded according to <a href="http://odata.org">OData Protocol</a> and is appended to the end of the url.</p>

<p>The OData Protocol specification defines how to standardize a typed, resource-oriented CRUD interface for manipulating data sources by providing collections of entries which must have required elements.</p>



<h4 id="filter">filter</h4>

<p>Equivalent to if (field == â€œvalueâ€ &amp;&amp; secondField &gt;= 33 || thirdField &lt; 132000).</p>



<pre class="prettyprint"><code class="language-objective-c hljs erlang">[<span class="hljs-keyword">query</span> filter<span class="hljs-variable">Field</span>:@<span class="hljs-string">"field"</span> relation<span class="hljs-variable">Operator</span>:@<span class="hljs-string">"=="</span> value:@<span class="hljs-string">"value"</span>];
[<span class="hljs-keyword">query</span> filter<span class="hljs-variable">And</span>];
[<span class="hljs-keyword">query</span> filter<span class="hljs-variable">Field</span>:@<span class="hljs-string">"secondField"</span> relation<span class="hljs-variable">Operator</span>:@<span class="hljs-string">"&gt;="</span> value:[<span class="hljs-variable">NSNumber</span> number<span class="hljs-variable">WithInt</span>:<span class="hljs-number">33</span>]];
[<span class="hljs-keyword">query</span> filter<span class="hljs-variable">Or</span>];
[<span class="hljs-keyword">query</span> filter<span class="hljs-variable">Field</span>:@<span class="hljs-string">"thirdField"</span> relation<span class="hljs-variable">Operator</span>:@<span class="hljs-string">"&lt;"</span> value:[<span class="hljs-variable">NSNumber</span> number<span class="hljs-variable">WithInt</span>:<span class="hljs-number">132000</span>]];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs erlang"><span class="hljs-keyword">query</span>.filter<span class="hljs-variable">Field</span>(<span class="hljs-string">"field"</span>, relation<span class="hljs-variable">Operator</span>: <span class="hljs-string">"=="</span>, value: <span class="hljs-string">"value"</span>)
<span class="hljs-keyword">query</span>.filter<span class="hljs-variable">And</span>()
<span class="hljs-keyword">query</span>.filter<span class="hljs-variable">Field</span>(<span class="hljs-string">"secondField"</span>, relation<span class="hljs-variable">Operator</span>: <span class="hljs-string">"&gt;="</span>, value: <span class="hljs-variable">NSNumber</span>(int: <span class="hljs-number">33</span>))
<span class="hljs-keyword">query</span>.filter<span class="hljs-variable">Or</span>()
<span class="hljs-keyword">query</span>.filter<span class="hljs-variable">Field</span>(<span class="hljs-string">"thirdField"</span>, relation<span class="hljs-variable">Operator</span>: <span class="hljs-string">"&lt;"</span>, value: <span class="hljs-variable">NSNumber</span>(int: <span class="hljs-number">132000</span>))</code></pre>

<p>Available relation operators</p>

<ul>
<li><code>==</code> or <code>eq</code></li>
<li><code>!=</code> or <code>ne</code></li>
<li><code>&gt;=</code> or <code>ge</code></li>
<li><code>&lt;=</code> or <code>le</code></li>
<li><code>&gt;</code> or <code>gt</code></li>
<li><code>&lt;</code> or <code>lt</code></li>
</ul>



<h4 id="startswith">startswith</h4>



<pre class="prettyprint"><code class="language-objective-c hljs erlang">[<span class="hljs-keyword">query</span> starts<span class="hljs-variable">With</span>:@<span class="hljs-string">"a"</span> field:@<span class="hljs-string">"name"</span>];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs erlang"><span class="hljs-keyword">query</span>.starts<span class="hljs-variable">With</span>(<span class="hljs-string">"a"</span>, field:<span class="hljs-string">"name"</span>)</code></pre>



<h4 id="endswith">endswith</h4>



<pre class="prettyprint"><code class="language-objective-c hljs erlang">[<span class="hljs-keyword">query</span> ends<span class="hljs-variable">With</span>:@<span class="hljs-string">"z"</span> field:@<span class="hljs-string">"name"</span>];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs erlang"><span class="hljs-keyword">query</span>.ends<span class="hljs-variable">With</span>(<span class="hljs-string">"z"</span>, field:<span class="hljs-string">"name"</span>)</code></pre>



<h4 id="substringof">substringof</h4>



<pre class="prettyprint"><code class="language-objective-c hljs erlang">[<span class="hljs-keyword">query</span> substring<span class="hljs-variable">Of</span>:@<span class="hljs-string">"bc"</span> field:@<span class="hljs-string">"name"</span>];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs erlang"><span class="hljs-keyword">query</span>.substring<span class="hljs-variable">Of</span>(<span class="hljs-string">"bc"</span>, field:<span class="hljs-string">"name"</span>)</code></pre>



<h4 id="in">in</h4>



<pre class="prettyprint"><code class="language-objective-c hljs erlang">[<span class="hljs-keyword">query</span> filter<span class="hljs-variable">In</span>:@<span class="hljs-string">"name"</span> values:@<span class="hljs-string">"Lucas,Thomas"</span>];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs erlang"><span class="hljs-keyword">query</span>.filter<span class="hljs-variable">In</span>(<span class="hljs-string">"name"</span>, values:<span class="hljs-string">"Lucas,Thomas"</span>)</code></pre>



<h4 id="nin">nin</h4>



<pre class="prettyprint"><code class="language-objective-c hljs bash">[query filterN<span class="hljs-keyword">in</span>:@<span class="hljs-string">"name"</span> values:@<span class="hljs-string">"John,Mark"</span>];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs bash">query.filterN<span class="hljs-keyword">in</span>(<span class="hljs-string">"name"</span>, values:<span class="hljs-string">"John,Mark"</span>)</code></pre>



<h4 id="select">select</h4>



<pre class="prettyprint"><code class="language-objective-c hljs erlang">[<span class="hljs-keyword">query</span> select:@<span class="hljs-string">"firstName,lastName"</span>];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs erlang"><span class="hljs-keyword">query</span>.select(<span class="hljs-string">"firstName,lastName"</span>)</code></pre>



<h4 id="top">top</h4>



<pre class="prettyprint"><code class="language-objective-c hljs ini"><span class="hljs-title">[query top:5]</span><span class="hljs-comment">;</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs erlang"><span class="hljs-keyword">query</span>.top(<span class="hljs-number">5</span>)</code></pre>



<h4 id="orderby">orderby</h4>



<pre class="prettyprint"><code class="language-objective-c hljs erlang">[<span class="hljs-keyword">query</span> order<span class="hljs-variable">By</span>:<span class="hljs-string">"name"</span> direction:<span class="hljs-variable">OrderByDirectionAsc</span>];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs avrasm">query<span class="hljs-preprocessor">.orderBy</span>(<span class="hljs-string">"name"</span>, direction:<span class="hljs-preprocessor">.Asc</span>)</code></pre>



<h4 id="inlinecount">inlinecount</h4>



<pre class="prettyprint"><code class="language-objective-c hljs ini"><span class="hljs-title">[query inlineCount:YES]</span><span class="hljs-comment">;</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs erlang"><span class="hljs-keyword">query</span>.inline<span class="hljs-variable">Count</span>(<span class="hljs-literal">true</span>)</code></pre>



<h4 id="skip">skip</h4>



<pre class="prettyprint"><code class="language-objective-c hljs ini"><span class="hljs-title">[query skip:32]</span><span class="hljs-comment">;</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs erlang"><span class="hljs-keyword">query</span>.skip(<span class="hljs-number">32</span>)</code></pre>



<h3 id="querying-objects">Querying objects</h3>

<p>If query is prepared, you just call find method.</p>



<pre class="prettyprint"><code class="language-objective-c hljs erlang">[<span class="hljs-keyword">query</span> find:^(<span class="hljs-variable">SResponseWrapper</span> *result) <span class="hljs-tuple">{
    // <span class="hljs-variable">Handle</span> result
}</span>]</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript">query.find {
    <span class="hljs-function"><span class="hljs-params">(result : SResponseWrapper!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
    <span class="hljs-regexp">//</span> Handle result
}</code></pre>



<h3 id="list-all-users">List all users</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">object</td>
  <td align="left">SynergykitUser</td>
  <td align="left">Determines location and return type</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>


<p><code>SQuery</code> with <code>SynergykitUser</code> object without conditions.</p>



<pre class="prettyprint"><code class="language-objective-c hljs perl">SynergykitUser <span class="hljs-variable">*user</span> = [SynergykitUser new];

SQuery <span class="hljs-variable">*query</span> = [[SQuery alloc] initWithObject:user];

[query find:^(SResponseWrapper <span class="hljs-variable">*result</span>) {
    <span class="hljs-regexp">//</span> Handle received objects
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> user = SynergykitUser()

<span class="hljs-reserved">let</span> query = SQuery(<span class="hljs-attribute">object</span>: user)

query.find {
  <span class="hljs-function"><span class="hljs-params">(result : SResponseWrapper!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
    <span class="hljs-regexp">//</span> Handle received objects
}</code></pre>



<h3 id="list-all-documents">List all documents</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">object</td>
  <td align="left">SynergykitObject</td>
  <td align="left">Determines location and return type</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>


<p><code>SQuery</code> with <code>SynergykitObject</code> object without conditions.</p>



<pre class="prettyprint"><code class="language-objective-c hljs haskell"><span class="hljs-type">SynergykitObject</span> *<span class="hljs-typedef"><span class="hljs-keyword">data</span> = [[<span class="hljs-type">SynergykitObject</span> alloc] initWithCollection:@"target-collection"];</span>

<span class="hljs-type">SQuery</span> *query = [[<span class="hljs-type">SQuery</span> alloc] initWithObject:<span class="hljs-typedef"><span class="hljs-keyword">data</span>];</span>

[query find:^(<span class="hljs-type">SResponseWrapper</span> *result) {
    // <span class="hljs-type">Handle</span> received objects
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs lasso"><span class="hljs-keyword">let</span> <span class="hljs-built_in">data</span> <span class="hljs-subst">=</span> SynergykitObject(collection: <span class="hljs-string">"target-collection"</span>)

<span class="hljs-keyword">let</span> query <span class="hljs-subst">=</span> SQuery(object: <span class="hljs-built_in">data</span>)

query<span class="hljs-built_in">.</span>find {
  (result : SResponseWrapper<span class="hljs-subst">!</span>) <span class="hljs-subst">-&gt; </span><span class="hljs-literal">Void</span> <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle received objects</span>
}</code></pre>



<h3 id="list-all-files">List all files</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">object</td>
  <td align="left">SFile</td>
  <td align="left">Determines location and return type</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>


<p><code>SQuery</code> with <code>SFile</code> object without conditions.</p>



<pre class="prettyprint"><code class="language-objective-c hljs perl">SFile <span class="hljs-variable">*file</span> = [SFile new];

SQuery <span class="hljs-variable">*query</span> = [[SQuery alloc] initWithObject:file];

[query find:^(SResponseWrapper <span class="hljs-variable">*result</span>) {
    <span class="hljs-regexp">//</span> Handle received objects
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs lasso"><span class="hljs-keyword">let</span> <span class="hljs-built_in">data</span> <span class="hljs-subst">=</span> SFile()

<span class="hljs-keyword">let</span> query <span class="hljs-subst">=</span> SQuery(object: file)

query<span class="hljs-built_in">.</span>find {
  (result : SResponseWrapper<span class="hljs-subst">!</span>) <span class="hljs-subst">-&gt; </span><span class="hljs-literal">Void</span> <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle received objects</span>
}</code></pre>



<h2 id="users">Users</h2>

<p>Users are alfa and omega of every application. In SynergyKit you can easily work with your users by methods listed below.</p>



<h3 id="create-a-new-user">Create a new user</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">*</td>
  <td align="left">?</td>
  <td align="left">Optional parameters</td>
  <td align="center">optional</td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SynergykitUser *user = [SynergykitUser <span class="hljs-keyword">new</span>];

[user save:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> user = SynergykitUser()

user.save {
  <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
  <span class="hljs-regexp">//</span> Handle result
}</code></pre>



<h3 id="retrieve-an-existing-user-by-id">Retrieve an existing user by ID</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SynergykitUser *user = [[SynergykitUser alloc] initWithId:<span class="hljs-string">@"object-id"</span>];

[user fetch:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> user = SynergykitUser(<span class="hljs-attribute">id</span>: <span class="hljs-string">"object-id"</span>)

user.fetch {
  <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
  <span class="hljs-regexp">//</span> Handle result
}</code></pre>



<h3 id="update-user">Update user</h3>

<p>Save method executes <code>PUT</code> request if <code>_id</code> is set. </p>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">*</td>
  <td align="left">?</td>
  <td align="left">Optional parameters</td>
  <td align="center">optional</td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SynergykitUser *user = [[SynergykitUser alloc] initWithId:<span class="hljs-string">@"object-id"</span>];

[user save:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> user = SynergykitUser(<span class="hljs-attribute">id</span>: <span class="hljs-string">"object-id"</span>)

user.save {
  <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
  <span class="hljs-regexp">//</span> Handle result
}</code></pre>



<h3 id="delete-user">Delete user</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SynergykitUser *user = [[SynergykitUser alloc] initWithId:<span class="hljs-string">@"object-id"</span>];

[user destroy:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> user = SynergykitUser(<span class="hljs-attribute">id</span>: <span class="hljs-string">"object-id"</span>)

user.destroy {
  <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
  <span class="hljs-regexp">//</span> Handle result
}</code></pre>



<h3 id="add-role">Add role</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">role</td>
  <td align="left">NSString</td>
  <td align="left"></td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SynergykitUser *user = [[SynergykitUser alloc] initWithId:<span class="hljs-string">@"object-id"</span>];

[user addRole:<span class="hljs-string">@"master"</span> handler:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> user = SynergykitUser(<span class="hljs-attribute">id</span>: <span class="hljs-string">"object-id"</span>)

user.addRole(<span class="hljs-string">"master"</span>, <span class="hljs-attribute">handler</span>: {
  <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
  <span class="hljs-regexp">//</span> Handle result
})</code></pre>



<h3 id="remove-role">Remove role</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">role</td>
  <td align="left">NSString</td>
  <td align="left"></td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SynergykitUser *user = [[SynergykitUser alloc] initWithId:<span class="hljs-string">@"object-id"</span>];

[user removeRole:<span class="hljs-string">@"master"</span> handler:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> user = SynergykitUser(<span class="hljs-attribute">id</span>: <span class="hljs-string">"object-id"</span>)

user.removeRole(<span class="hljs-string">"master"</span>, <span class="hljs-attribute">handler</span>: {
  <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
  <span class="hljs-regexp">//</span> Handle result
})</code></pre>



<h3 id="add-platform-to-user">Add platform to user</h3>

<p>Platforms are useful for pairing individual mobile devices or web applications to the user via registration ID. After assignment platform to the user you will be able to send push notifications to the device or application.</p>

<p><strong>Before you start working</strong> with platforms of user is needed to login first. After successful login SDK receives sessionToken for authentication of user. Token is held by the SDK and is automatically inserted into the Headers.</p>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">development</td>
  <td align="left">NSNumber</td>
  <td align="left">Use development certificate for APNS</td>
  <td align="center">optional</td>
</tr>
<tr>
  <td align="left">registrationId</td>
  <td align="left">NSString</td>
  <td align="left">Device id</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs objectivec">SPlatform *platform = [SPlatform new];
platform<span class="hljs-variable">.registrationId</span> = @<span class="hljs-string">"device-token"</span>;
platform<span class="hljs-variable">.development</span> = [<span class="hljs-built_in">NSNumber</span> numberWithBool:<span class="hljs-literal">YES</span>];

[platform save:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs livecodeserver">let <span class="hljs-built_in">platform</span> = SPlatform()
<span class="hljs-built_in">platform</span>.registrationId = <span class="hljs-string">"device-token"</span>
<span class="hljs-built_in">platform</span>.development = NSNumber(bool: <span class="hljs-constant">true</span>)

<span class="hljs-built_in">platform</span>.save {
  (<span class="hljs-built_in">result</span> : SResponse!) -&gt; Void <span class="hljs-operator">in</span>
 <span class="hljs-comment"> // Handle result</span>
}</code></pre>



<h3 id="retrive-platform">Retrive platform</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SPlatform *platform = [[SPlatform alloc] initWithId:<span class="hljs-string">@"platform-id"</span>];

[platform fetch:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs livecodeserver">let <span class="hljs-built_in">platform</span> = SPlatform(id: <span class="hljs-string">"platform-id"</span>)

<span class="hljs-built_in">platform</span>.fetch {
  (<span class="hljs-built_in">result</span> : SResponse!) -&gt; Void <span class="hljs-operator">in</span>
 <span class="hljs-comment"> // Handle result</span>
}</code></pre>



<h3 id="update-platform">Update platform</h3>

<p>Platforms contain of a few parameters but only two are updatable. Save method executes <code>PUT</code> request if <code>_id</code> is set, it could change <code>development</code> and <code>registrationId</code>. </p>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">registrationId</td>
  <td align="left">NSString</td>
  <td align="left">Device id</td>
  <td align="center">optional</td>
</tr>
<tr>
  <td align="left">development</td>
  <td align="left">NSString</td>
  <td align="left">Use development certificate for APNS</td>
  <td align="center">optional</td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs objectivec">SPlatform *platform = [[SPlatform alloc] initWithId:@<span class="hljs-string">"platform-id"</span>];
platform<span class="hljs-variable">.registrationId</span> = @<span class="hljs-string">"new-device-token"</span>;
platform<span class="hljs-variable">.development</span> = [<span class="hljs-built_in">NSNumber</span> numberWithBool:<span class="hljs-literal">NO</span>];

[platform save:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs livecodeserver">let <span class="hljs-built_in">platform</span> = SPlatform(id: <span class="hljs-string">"platform-id"</span>)
<span class="hljs-built_in">platform</span>.registrationId = <span class="hljs-string">"new-device-token"</span>
<span class="hljs-built_in">platform</span>.development = NSNumber(bool: <span class="hljs-constant">false</span>)

<span class="hljs-built_in">platform</span>.save {
  (<span class="hljs-built_in">result</span> : SResponse!) -&gt; Void <span class="hljs-operator">in</span>
 <span class="hljs-comment"> // Handle result</span>
}</code></pre>



<h3 id="delete-platform">Delete platform</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SPlatform *platform = [[SPlatform alloc] initWithId:<span class="hljs-string">@"platform-id"</span>];

[platform destroy:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs livecodeserver">let <span class="hljs-built_in">platform</span> = SPlatform(id: <span class="hljs-string">"platform-id"</span>)

<span class="hljs-built_in">platform</span>.destroy {
  (<span class="hljs-built_in">result</span> : SResponse!) -&gt; Void <span class="hljs-operator">in</span>
 <span class="hljs-comment"> // Handle result</span>
}</code></pre>



<h3 id="activating-user">Activating user</h3>

<p>By default, user is not activated. This mean, that you can use this state to validate user e-mail address by sending him activation link.</p>

<p>To activate user, send an email with this activation link /v2/users/activation/[ACTIVATION_HASH]. You can provide parameter callback with url address where you want to redirect user after activation.</p>

<p>Or <strong>if you know that e-mai address is valid</strong> you can activate user with SDK.</p>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SynergykitUser *user = [[SynergykitUser alloc] initWithId:<span class="hljs-string">@"object-id"</span>];

[user activate:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> user = SynergykitUser(<span class="hljs-attribute">id</span>: <span class="hljs-string">"object-id"</span>)

user.activate {
  <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
  <span class="hljs-regexp">//</span> Handle result
}</code></pre>



<h3 id="login-user">Login user</h3>

<p>If user was registrated via normal way, which means by email and password, you can authenticate him with login method.</p>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">email</td>
  <td align="left">NSString</td>
  <td align="left">User e-mail</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">password</td>
  <td align="left">NSString</td>
  <td align="left">User password</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SynergykitUser *user = [SynergykitUser <span class="hljs-keyword">new</span>];
user.email = <span class="hljs-string">@"dummy@synergykit.com"</span>;
user.password = <span class="hljs-string">@"my-password"</span>;

[user login:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> user = SynergykitUser()
user.email = <span class="hljs-string">"dummy@synergykit.com"</span>;
user.password = <span class="hljs-string">"my-password"</span>;

user.login {
  <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
  <span class="hljs-regexp">//</span> Handle result
}</code></pre>



<h2 id="communication">Communication</h2>

<p>In SynergyKit you can communicate with your users by different ways. There are listed some methods below this section.</p>

<p>One way is sending push notifications into user devices. This action need to have filled your API key for Android devices in Settings, section Android. For push notifications into iOS devices you need to fill your password and certificates into Apple section in Settings.</p>

<p>Another way is sending emails to your users. For this you need to create email templates in administration under Mailing section.</p>



<h3 id="send-notification">Send notification</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">recipients</td>
  <td align="left">NSArray</td>
  <td align="left">List of recipient</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">alert</td>
  <td align="left">NSString</td>
  <td align="left">Alert message of notification</td>
  <td align="center">optional</td>
</tr>
<tr>
  <td align="left">badge</td>
  <td align="left">NSNumber</td>
  <td align="left">Badge to be shown on app icon</td>
  <td align="center">optional</td>
</tr>
<tr>
  <td align="left">payload</td>
  <td align="left">NSString</td>
  <td align="left">Notification payload</td>
  <td align="center">optional</td>
</tr>
<tr>
  <td align="left">sound</td>
  <td align="left">NSString</td>
  <td align="left">Soud to be played on notification income</td>
  <td align="center">optional</td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs perl">SynergykitUser <span class="hljs-variable">*user</span> = [[SynergykitUser alloc] initWithId:<span class="hljs-variable">@"</span>user-id<span class="hljs-string">"];

SNotification <span class="hljs-variable">*notification</span> = [[SNotification alloc] initWithRecipient:user];
notification.alert = <span class="hljs-variable">@"</span>Hello Lucas"</span>;

[notification <span class="hljs-keyword">send</span>:^(SResponse <span class="hljs-variable">*result</span>) {
    <span class="hljs-regexp">//</span> Handle result
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> user = SynergykitUser(<span class="hljs-attribute">id</span>: <span class="hljs-string">"user-id"</span>)

<span class="hljs-reserved">let</span> notification = SNotification(<span class="hljs-attribute">recipient</span>: user)
notification.alert = <span class="hljs-string">"Hello Lucas"</span>

notification.send {
  <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
  <span class="hljs-regexp">//</span> Handle result
}</code></pre>



<h3 id="send-e-mail">Send e-mail</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">from</td>
  <td align="left">NSString</td>
  <td align="left">The sender of e-mail</td>
  <td align="center">optional</td>
</tr>
<tr>
  <td align="left">to</td>
  <td align="left">NSString</td>
  <td align="left">Recipient of e-mail</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">subject</td>
  <td align="left">NSString</td>
  <td align="left">Subject of e-mail</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">templateName</td>
  <td align="left">NSString</td>
  <td align="left">Name of template</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">args</td>
  <td align="left">NSArray</td>
  <td align="left">Mailing template arguments</td>
  <td align="center">optional</td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs fsharp">SynergykitUser *user = [SynergykitUser <span class="hljs-keyword">new</span>];
user.email = <span class="hljs-string">@"dummy@synergykit.com"</span>;

SEmail *email = [SEmail <span class="hljs-keyword">new</span>];
email.<span class="hljs-keyword">to</span> = user;
email.subject = <span class="hljs-string">@"Email Example"</span>;
email.templateName = <span class="hljs-string">@"email-example"</span>;
email.args = @{<span class="hljs-string">@"name"</span>: <span class="hljs-string">@"Lucas"</span>}; <span class="hljs-comment">// according template</span>

[email send:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs avrasm">let user = SynergykitUser()
user<span class="hljs-preprocessor">.email</span> = <span class="hljs-string">"dummy@synergykit.com"</span>

let email = SEmail()
email<span class="hljs-preprocessor">.to</span> = user
email<span class="hljs-preprocessor">.subject</span> = <span class="hljs-string">"Email Example"</span>
email<span class="hljs-preprocessor">.templateName</span> = <span class="hljs-string">"email-example"</span>
email<span class="hljs-preprocessor">.args</span> = [<span class="hljs-string">"name"</span>: <span class="hljs-string">"Lucas"</span>] // according template

email<span class="hljs-preprocessor">.send</span> {
  (result : SResponse!) -&gt; Void <span class="hljs-keyword">in</span>
  // Handle result
}</code></pre>

<p><strong>Shorter form</strong></p>



<pre class="prettyprint"><code class="language-swift hljs avrasm">let user = SynergykitUser()
user<span class="hljs-preprocessor">.email</span> = <span class="hljs-string">"dummy@synergykit.com"</span>

SEmail()<span class="hljs-preprocessor">.to</span>(user)<span class="hljs-preprocessor">.subject</span>(<span class="hljs-string">"Email Example"</span>)<span class="hljs-preprocessor">.templateName</span>(<span class="hljs-string">"email-example"</span>)<span class="hljs-preprocessor">.args</span>([<span class="hljs-string">"name"</span>: <span class="hljs-string">"Lucas"</span>])<span class="hljs-preprocessor">.send</span> {
  (result : SResponse!) -&gt; Void <span class="hljs-keyword">in</span>
  // Handle result
}</code></pre>

<p>E-mail template should looks like this example.</p>



<pre class="prettyprint"><code class=" hljs xml"><span class="hljs-tag">&lt;<span class="hljs-title">p</span>&gt;</span>Hello %name%,<span class="hljs-tag">&lt;/<span class="hljs-title">p</span>&gt;</span>
<span class="hljs-tag">&lt;<span class="hljs-title">br</span>&gt;</span>
<span class="hljs-tag">&lt;<span class="hljs-title">p</span>&gt;</span>this e-mail was send from Synergykit Sample Application.<span class="hljs-tag">&lt;/<span class="hljs-title">p</span>&gt;</span>
<span class="hljs-tag">&lt;<span class="hljs-title">br</span>&gt;</span>
<span class="hljs-tag">&lt;<span class="hljs-title">p</span>&gt;</span>Synergykit Team<span class="hljs-tag">&lt;/<span class="hljs-title">p</span>&gt;</span></code></pre>



<h2 id="files">Files</h2>



<h3 id="upload-file">Upload file</h3>

<p>SynergyKit SDK supports upload with many file types, there is example of image upload. If file is successfully uploaded <code>SFile</code> representing just created file object is returned. <code>SFile</code> contains path to file from where is file accessible.</p>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">data</td>
  <td align="left">NSData</td>
  <td align="left">Data representing file</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs perl">SFile <span class="hljs-variable">*file</span> = [SFile new];

UIImage <span class="hljs-variable">*imageToUpload</span> = [UIImage imageNamed:<span class="hljs-variable">@"</span>synergykit-logo<span class="hljs-string">"];
NSData <span class="hljs-variable">*imageData</span> = UIImageJPEGRepresentation(imageToUpload, 1.0);

[file uploadJPEGImage:imageData handler:^(SResponse <span class="hljs-variable">*result</span>) {
    // Handle result
}];</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> file = SFile()

<span class="hljs-reserved">let</span> imageToUpload = UIImage(<span class="hljs-attribute">named</span>:<span class="hljs-string">"synergykit-logo"</span>)
<span class="hljs-reserved">let</span> imageData = UIImageJPEGRepresentation(imageToUpload, <span class="hljs-number">1.0</span>)

file.uploadJPEGImage(imageData <span class="hljs-attribute">handler</span>: {
  <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
  <span class="hljs-regexp">//</span> Handle result
})</code></pre>



<h3 id="retrieve-file-by-id">Retrieve file by ID</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs scss"><span class="hljs-attr_selector">[[SFile alloc]</span> initWithId<span class="hljs-value">:@<span class="hljs-string">"file-id"</span>] fetch:^(SResponse *result) {
    // Handle result
}];</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript">SFile(<span class="hljs-attribute">id</span>: <span class="hljs-string">"file-id"</span>).fetch {
    <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
    <span class="hljs-regexp">//</span> Handle result
}</code></pre>



<h3 id="delete-file">Delete file</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">_id</td>
  <td align="left">NSString</td>
  <td align="left">API identificator</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs scss"><span class="hljs-attr_selector">[[SFile alloc]</span> initWithId<span class="hljs-value">:@<span class="hljs-string">"file-id"</span>] destroy:^(SResponse *result) {
    // Handle result
}];</span></code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript">SFile(<span class="hljs-attribute">id</span>: <span class="hljs-string">"file-id"</span>).destroy {
    <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
    <span class="hljs-regexp">//</span> Handle result
}</code></pre>



<h2 id="cloud-code">Cloud Code</h2>

<p>Our vision is to let developers build any app without dealing with servers. For complex apps, sometimes you just need a bit of logic that isnâ€™t running on a mobile device. Cloud Code makes this possible.</p>

<p>Cloud Code runs in the Node.js jailed sandbox and uses strict JavaScript language with some prepared modules and variables, which you can use for your development. <br>
mac</p>



<h3 id="run-cloud-code">Run cloud code</h3>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">name</td>
  <td align="left">NSString</td>
  <td align="left">Function name</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">args</td>
  <td align="left">NSArray</td>
  <td align="left">Parameters to pass into function</td>
  <td align="center">optional</td>
</tr>
<tr>
  <td align="left">resultType</td>
  <td align="left">Class</td>
  <td align="left">Type of returned data</td>
  <td align="center">optional</td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs ruby"><span class="hljs-constant">SCloudCode</span> *cloudCode = [[<span class="hljs-constant">SCloudCode</span> alloc] <span class="hljs-symbol">initWithName:</span>@<span class="hljs-string">"example"</span> <span class="hljs-symbol">args:</span>@{@<span class="hljs-string">"name"</span><span class="hljs-symbol">:</span> @<span class="hljs-string">"Lucas"</span>} <span class="hljs-symbol">resultType:</span><span class="hljs-keyword">nil</span>];

[cloudCode <span class="hljs-symbol">invoke:</span>^(<span class="hljs-constant">SResponse</span> *result) {
    <span class="hljs-regexp">//</span> <span class="hljs-constant">Handle</span> result
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> cloudCode = SCloudCode(<span class="hljs-attribute">name</span>: <span class="hljs-string">"example"</span>, <span class="hljs-attribute">args</span>: [<span class="hljs-string">"name"</span>: <span class="hljs-string">"Lucas"</span>], <span class="hljs-attribute">resultType</span>: nil)

cloudCode.invoke {
    <span class="hljs-function"><span class="hljs-params">(result : SResponse!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
    <span class="hljs-regexp">//</span> Handle result
}</code></pre>

<p>Example cloud code function should looks like this.</p>



<pre class="prettyprint"><code class=" hljs erlang"><span class="hljs-function"><span class="hljs-title">callback</span><span class="hljs-params">(<span class="hljs-string">"Hello "</span> + parameters.name + <span class="hljs-string">"!"</span>)</span></span></code></pre>



<h2 id="batch-request">Batch request</h2>

<p>We know that internet connection is sometimes unstable and we know itâ€™s not really good for synchronization algorithm where dozens of requests need to be executed without mistake. Batch request minimizes risk with connection failure - itâ€™s all in one or nothing, not first five request, then two failed (walk under the bridge) and at the end three successful.</p>



<h3 id="sbatchitem">SBatchItem</h3>

<p>You can batch every request you can imagine with <code>SBatchItem</code> object. At first create batch item that says where and how to do it.</p>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">id</td>
  <td align="left">NSNumber</td>
  <td align="left">Developer identificator of request</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">method</td>
  <td align="left">SMethodType</td>
  <td align="left">REST method</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">endpoint</td>
  <td align="left">NSString</td>
  <td align="left">REST API endpoint</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">body</td>
  <td align="left">Child of SynergykitObject</td>
  <td align="left">POST request body</td>
  <td align="center">optional</td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs objectivec">SBatchItem *item = [[SBatchItem alloc] initWithId:[<span class="hljs-built_in">NSNumber</span> numberWithInt:<span class="hljs-number">1</span>] method:SMethodTypeGET endpoint:@<span class="hljs-string">"/data/target-collection"</span> body:<span class="hljs-literal">nil</span>];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs objectivec">let batchItem = SBatchItem(<span class="hljs-keyword">id</span>: <span class="hljs-built_in">NSNumber</span>(<span class="hljs-keyword">int</span>: <span class="hljs-number">1</span>), method: <span class="hljs-variable">.GET</span>, endpoint: <span class="hljs-string">"/data/target-collection"</span>, body: <span class="hljs-literal">nil</span>)</code></pre>



<h3 id="sbatchitemwrapper">SBatchItemWrapper</h3>

<p>Every batch item needs to be wrapped in <code>SBatchItemWrapper</code> where you can say what is expected in callback. If no type is set, request returns result as <code>NSDictionary</code>. Wrapper offers you to handle request response explicitly with handler. If handler is not set nothing happens, every request is handled implicitly in batch execution callback.</p>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">item</td>
  <td align="left">SBatchItem</td>
  <td align="left">Batch item</td>
  <td align="center"><strong>required</strong></td>
</tr>
<tr>
  <td align="left">handler</td>
  <td align="left">NSString</td>
  <td align="left">Explicit handler for request</td>
  <td align="center">optional</td>
</tr>
<tr>
  <td align="left">type</td>
  <td align="left">Class</td>
  <td align="left">Return type</td>
  <td align="center">optional</td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs delphi">SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item <span class="hljs-keyword">type</span>: DemoObject.<span class="hljs-keyword">class</span> handler:<span class="hljs-keyword">nil</span>];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs fsharp"><span class="hljs-keyword">let</span> wrapper = SBatchItemWrapper(item, <span class="hljs-class"><span class="hljs-keyword">type</span>: <span class="hljs-title">DemoObject</span>.<span class="hljs-title">self</span>, <span class="hljs-title">handler</span>:<span class="hljs-title">nil</span>)</span></code></pre>



<h3 id="sbatch">SBatch</h3>

<p>Execution of items is in <code>SBatch</code> object. Batch executes every request in the order in which they were added.</p>

<table>
<thead>
<tr>
  <th align="left">Parameter</th>
  <th align="left">Type</th>
  <th align="left">Notes</th>
  <th align="center"></th>
</tr>
</thead>
<tbody><tr>
  <td align="left">item</td>
  <td align="left">SBatchItemWrapper</td>
  <td align="left">Batch item wrapper</td>
  <td align="center"><strong>required</strong></td>
</tr>
</tbody></table>




<pre class="prettyprint"><code class="language-objective-c hljs cs">SBatch *batch = [SBatch <span class="hljs-keyword">new</span>];
[batch addItem:wrapper];

[batch executeWithCompletion:^(SResponseWrapper *result) {
   <span class="hljs-comment">// Handle all results implicitly</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs coffeescript"><span class="hljs-reserved">let</span> batch = SBatch()
batch.addItem(wrapper)

batch.executeWithCompletion {
    <span class="hljs-function"><span class="hljs-params">(results : SResponseWrapper!)</span> -&gt;</span> Void <span class="hljs-keyword">in</span>
    <span class="hljs-regexp">//</span> Handle all results implicitly
}</code></pre>



<h3 id="using-batch">Using batch</h3>

<p>SDK allows batch every request that is available as a single request. If there is <code>SynergykitObject</code> method <code>save</code>, there is opposite method <code>saveInBatch</code> that creates <code>SBatchItemWrapper</code> for you. After wrapper is generated you can just add it in <code>SBatch</code>.</p>



<pre class="prettyprint"><code class="language-objective-c hljs cs"><span class="hljs-comment">// Prepares requests</span>
SynergykitUser *user = [[SynergykitUser alloc] initWithId:<span class="hljs-string">@"user-id"</span>];
SBatchItemWrapper *userWrapper = [user fetchInBatch:^(SResponse *result) {
    <span class="hljs-comment">// Handle result explicitly</span>
}];

SynergykitObject *<span class="hljs-keyword">object</span> = [[SynergykitObject alloc] initWithCollection:<span class="hljs-string">@"target-collection"</span>];
SBatchItemWrapper *objectWrapper = [<span class="hljs-keyword">object</span> saveInBatch:nil];

SQuery *query = [[SQuery alloc] initWithObject:[SFile <span class="hljs-keyword">new</span>]];
[[query orderBy:<span class="hljs-string">@"size"</span> direction:OrderByDirectionDesc] top:<span class="hljs-number">10</span>];
SBatchItemWrapper *queryWrapper = [query findInBatch:nil];

SBatch *batch = [SBatch <span class="hljs-keyword">new</span>];

<span class="hljs-comment">// Fills batch with requests</span>
[batch addItem:userWrapper];
[batch addItems:@[objectWrapper, queryWrapper]];

[batch executeWithCompletion:^(SResponseWrapper *result) {
   <span class="hljs-comment">// Handle all results implicitly</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs cs"><span class="hljs-comment">// Prepares requests</span>
<span class="hljs-keyword">let</span> user = SynergykitUser(id: <span class="hljs-string">"user-id"</span>)
<span class="hljs-keyword">let</span> userWrapper = user .fetchInBatch {
    (result : SResponse!) -&gt; Void <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle result explicitly</span>
}

<span class="hljs-keyword">let</span> <span class="hljs-keyword">object</span> = SynergykitObject(collection: <span class="hljs-string">"target-collection"</span>)
<span class="hljs-keyword">let</span> objectWrapper = <span class="hljs-keyword">object</span> .saveInBatch(nil)

<span class="hljs-keyword">let</span> query = SQuery(<span class="hljs-keyword">object</span>: SFile())
query.orderBy(<span class="hljs-string">"size"</span>, direction: .Desc).top(<span class="hljs-number">10</span>)
<span class="hljs-keyword">let</span> queryWrapper = query.findInBatch(nil)

<span class="hljs-keyword">let</span> batch = SBatch()

<span class="hljs-comment">// Fills batch with requets</span>
batch.addItem(userWrapper)
batch.addItems([objectWrapper, queryWrapper])

batch.executeWithCompletion {
    (results : SResponseWrapper!) -&gt; Void <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle all results implicitly</span>
}</code></pre>



<h2 id="cache">Cache</h2>

<p>SynergyKit iOS SDK implements new advanced cache policy with <code>NSURLRequestCachePolicy</code> support. If you want to start using cache in communication with API, just set cache parameter on object.</p>



<h3 id="scachetypecacheelseload">SCacheTypeCacheElseLoad</h3>

<p>Returns cached data if exists.</p>



<pre class="prettyprint"><code class="language-objective-c hljs cs">SCache *cache = [[SCache alloc] initWithType:SCacheTypeCacheElseLoad];

SynergykitObject *<span class="hljs-keyword">object</span> = [[SynergykitObject alloc] initWithCollection:<span class="hljs-string">@"target-collection"</span> _id:<span class="hljs-string">@"object-id"</span>];
<span class="hljs-keyword">object</span>.cache = cache;

[<span class="hljs-keyword">object</span> fetch:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs lasso"><span class="hljs-keyword">let</span> <span class="hljs-keyword">cache</span> <span class="hljs-subst">=</span> SKCache(<span class="hljs-keyword">type</span>: <span class="hljs-built_in">.</span>CacheElseLoad)

<span class="hljs-keyword">let</span> object <span class="hljs-subst">=</span> SynergykitObject(collection: <span class="hljs-string">"target-collection"</span>, _id: <span class="hljs-string">"object-id"</span>)
object<span class="hljs-built_in">.</span><span class="hljs-keyword">cache</span> <span class="hljs-subst">=</span> <span class="hljs-keyword">cache</span>

object<span class="hljs-built_in">.</span>fetch {
    (result : SResponse<span class="hljs-subst">!</span>) <span class="hljs-subst">-&gt; </span><span class="hljs-literal">Void</span> <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle result</span>
}</code></pre>



<h3 id="scachetypeloadelsecache">SCacheTypeLoadElseCache</h3>

<p>Returns cached data if exists and internet connection is <strong>not available</strong>.</p>



<pre class="prettyprint"><code class="language-objective-c hljs cs">SCache *cache = [[SCache alloc] initWithType:SCacheTypeLoadElseCache];

SynergykitObject *<span class="hljs-keyword">object</span> = [[SynergykitObject alloc] initWithCollection:<span class="hljs-string">@"target-collection"</span> _id:<span class="hljs-string">@"object-id"</span>];
<span class="hljs-keyword">object</span>.cache = cache;

[<span class="hljs-keyword">object</span> fetch:^(SResponse *result) {
    <span class="hljs-comment">// Handle result</span>
}];</code></pre>



<pre class="prettyprint"><code class="language-swift hljs lasso"><span class="hljs-keyword">let</span> <span class="hljs-keyword">cache</span> <span class="hljs-subst">=</span> SKCache(<span class="hljs-keyword">type</span>: <span class="hljs-built_in">.</span>LoadElseCache)

<span class="hljs-keyword">let</span> object <span class="hljs-subst">=</span> SynergykitObject(collection: <span class="hljs-string">"target-collection"</span>, _id: <span class="hljs-string">"object-id"</span>)
object<span class="hljs-built_in">.</span><span class="hljs-keyword">cache</span> <span class="hljs-subst">=</span> <span class="hljs-keyword">cache</span>

object<span class="hljs-built_in">.</span>fetch {
    (result : SResponse<span class="hljs-subst">!</span>) <span class="hljs-subst">-&gt; </span><span class="hljs-literal">Void</span> <span class="hljs-keyword">in</span>
    <span class="hljs-comment">// Handle result</span>
}</code></pre>



<h3 id="expiration-of-cached-data">Expiration of cached data</h3>

<p><code>SCacheTypeCacheElseLoad</code> and <code>SCacheTypeLoadElseCache</code> support expiration interval. Cached data will be invalidate after expiration.</p>



<pre class="prettyprint"><code class="language-objective-c hljs perl">// One hour expiration
SCache <span class="hljs-variable">*cache</span> = [[SCache alloc] initWithType:SCacheTypeCacheElseLoad expiration:<span class="hljs-number">60</span><span class="hljs-variable">*60</span>]; </code></pre>



<pre class="prettyprint"><code class="language-swift hljs fsharp"><span class="hljs-comment">// One hour expiration</span>
<span class="hljs-keyword">let</span> cache = SKCache(<span class="hljs-class"><span class="hljs-keyword">type</span>: .<span class="hljs-title">CacheElseLoad</span>, <span class="hljs-title">expiration</span>: 60*60)</span></code></pre>



<h2 id="changelog">Changelog</h2>



<h3 id="version-210-22-4-2015">Version 2.1.0 (22. 4. 2015)</h3>

<ul>
<li><strong>SynergyKit v2.1 support</strong></li>
<li>Documents</li>
<li>Real-time data observing</li>
<li>Queries</li>
<li>Users</li>
<li>Platforms</li>
<li>Roles</li>
<li>Communication</li>
<li>Files</li>
<li>CloudCode</li>
<li>Batching requests</li>
<li>Advanced Cache Policy</li>
</ul>



<h2 id="author">Author</h2>

<p><img src="http://letsgood.com/src/img/logo-letsgood.png" alt="SynergyKIT" title="SynergyKIT" width="120px"></p>

<p>Letsgood.com s.r.o., Prague, Heart of Europe - part of Etnetera Group.</p>

<p>development@letsgood.com, <a href="http://letsgood.com/en">http://letsgood.com/en</a></p>

<h2 id="license">License</h2>

<p>Synergykit iOS SDK is available under the MIT license. See the LICENSE file for more info.</p>
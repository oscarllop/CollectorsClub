using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Web;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System.Reflection;

namespace Core.Json {
	public class CustomJsonTextWriter : JsonTextWriter {
		public CustomJsonTextWriter(TextWriter textWriter)
			: base(textWriter) {
		}

		public int CurrentDepth { get; private set; }

		public override void WriteStartObject() {
			CurrentDepth++;
			base.WriteStartObject();
		}

		public override void WriteStartArray() {
			base.WriteStartArray();
		}

		public override void WriteEndObject() {
			base.WriteEndObject();
			CurrentDepth--;
		}
	}

	public class CustomContractResolver : DefaultContractResolver {
		private readonly Func<MemberInfo, bool> _includeProperty;

		public CustomContractResolver(Func<MemberInfo, bool> includeProperty) {
			_includeProperty = includeProperty;
		}

		protected override IList<JsonProperty> CreateProperties(Type type, MemberSerialization memberSerialization) {
			IList<JsonProperty> a = base.CreateProperties(type, memberSerialization);
			return a;
		}
		protected override JsonProperty CreateProperty(MemberInfo member, MemberSerialization memberSerialization) {
			var property = base.CreateProperty(member, memberSerialization);
			var shouldSerialize = property.ShouldSerialize;
			_includeProperty(member);
			property.ShouldSerialize = obj => _includeProperty(member) && (shouldSerialize == null || shouldSerialize(obj));
			return property;
		}

		protected override JsonObjectContract CreateObjectContract(Type objectType) {
			JsonObjectContract a = base.CreateObjectContract(objectType);
			return a;
		}
	}

	public class JsonConvert {
		public static string Serialize(object obj, int maxDepth) {
			using (var strWriter = new StringWriter()) {
				using (var jsonWriter = new CustomJsonTextWriter(strWriter)) {
					//Func<bool> include = () => jsonWriter.CurrentDepth <= maxDepth;
					Func<MemberInfo, bool> include = (m) => jsonWriter.CurrentDepth <= maxDepth;
					var resolver = new CustomContractResolver(include);
					var serializer = new JsonSerializer { ContractResolver = resolver };
					serializer.PreserveReferencesHandling = PreserveReferencesHandling.Objects;
					serializer.Serialize(jsonWriter, obj);
				}
				return strWriter.ToString();
			}
		}
	}
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using AutoMapper;
using CollectorsClub.Model.Mappers;

namespace CollectorsClub.Web.API.Mappers {
	public class AutoMapperConfiguration {
		public static void Configure() {
			Mapper.Initialize(x => {
				// Mapping CreateOrUpdateCommand <==> Model
				x.AddProfile<CreateOrUpdateCommandToModelMappingProfile>();
				x.AddProfile<ModelToCreateOrUpdateCommandMappingProfile>();
				// Mapping CreateOrUpdateCommand <==> Entity
				x.AddProfile<CreateOrUpdateCommandToEntityMappingProfile>();
				x.AddProfile<EntityToCreateOrUpdateCommandMappingProfile>();
				// Mapping Model <==> Entity
				x.AddProfile<ModelToEntityMappingProfile>();
				x.AddProfile<EntityToModelMappingProfile>();
				// Mapping Model <==> Model
				x.AddProfile<ModelToModelMappingProfile>();
			});
		}
	}
}

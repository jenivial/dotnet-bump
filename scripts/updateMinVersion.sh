currentVersion=$(xmlstarlet sel -t -v "Project/PropertyGroup/Version" DotnetBump/DotnetBump/DotnetBump.csproj)
newVersion=$(echo $currentVersion | awk 'BEGIN{FS=OFS="."}{$NF++}1')
xmlstarlet edit -L --update "Project/PropertyGroup/Version"  --value $newVersion DotnetBump/DotnetBump/DotnetBump.csproj